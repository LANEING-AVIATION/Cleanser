from multiprocessing import Value
from ctypes import c_float
from pymavlink import mavutil
import threading
import logging
import sys
import socket
import time
import subprocess
import os
import psutil

# 配置日志
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

# 配置串口和UDP端口
SERIAL_PORT = 'COM9'
BAUD_RATE = 57600
UDP_IP = "127.0.0.1"
UDP_PORT = 14550
QGC_PATH = r"C:\\Program Files\\QGroundControl\\QGroundControl.exe"

# 共享变量
center_x_shared = Value(c_float, 0.0)
center_y_shared = Value(c_float, 0.0)
area_shared = Value(c_float, 0.0)

# 连接到飞控的串口
try:
    connection = mavutil.mavlink_connection(SERIAL_PORT, baud=BAUD_RATE)
except Exception as e:
    logging.error(f"Failed to connect to MAVLink serial port: {e}")
    sys.exit(1)

# 创建UDP套接字
try:
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
except Exception as e:
    logging.error(f"Failed to create UDP socket: {e}")
    sys.exit(1)

# 等待心跳包，确认串口连接成功
logging.info("Waiting for heartbeat...")
try:
    connection.wait_heartbeat()
    logging.info(f"Heartbeat from system (system {connection.target_system} component {connection.target_component})")
except Exception as e:
    logging.error(f"Failed to receive heartbeat: {e}")
    sys.exit(1)

# 请求飞控状态信息
try:
    connection.mav.request_data_stream_send(
        connection.target_system,
        connection.target_component,
        mavutil.mavlink.MAV_DATA_STREAM_ALL,
        1, 1
    )
except Exception as e:
    logging.error(f"Failed to request data stream: {e}")
    sys.exit(1)

# 检查QGC是否已经运行
def is_qgc_running():
    for proc in psutil.process_iter(['pid', 'name']):
        if "QGroundControl.exe" in proc.info['name']:
            return True
    return False

# 启动QGC
def start_qgc():
    if not is_qgc_running():
        try:
            subprocess.Popen(QGC_PATH)
            logging.info("QGroundControl started successfully.")
        except Exception as e:
            logging.error(f"Failed to start QGroundControl: {e}")
    else:
        logging.info("QGroundControl is already running.")

# 从共享变量中获取最新的 box center 和 area
def get_latest_box_info():
    with center_x_shared.get_lock(), center_y_shared.get_lock(), area_shared.get_lock():
        return center_x_shared.value, center_y_shared.value, area_shared.value

# 定期报告共享变量值
def report_shared_values():
    while True:
        center_x, center_y, area = get_latest_box_info()
        logging.info(f"Shared values - Center X: {center_x}, Center Y: {center_y}, Area: {area}")
        time.sleep(1)

# 定义切换飞行模式的函数
def set_px4_mode(master, custom_mode, base_mode=mavutil.mavlink.MAV_MODE_FLAG_CUSTOM_MODE_ENABLED):
    try:
        print(f"尝试切换到自定义模式: {custom_mode} ")
        master.mav.command_long_send(
            master.target_system,
            master.target_component,
            mavutil.mavlink.MAV_CMD_DO_SET_MODE,
            0,
            base_mode,
            custom_mode,
            0, 0, 0, 0, 0
        )
        time.sleep(1)
        mode_feedback = master.recv_match(type='COMMAND_ACK', blocking=True, timeout=5)
        if mode_feedback:
            print(f"模式切换反馈: {mode_feedback}")
            if mode_feedback.result != mavutil.mavlink.MAV_RESULT_ACCEPTED:
                print(f"模式切换失败，错误代码: {mode_feedback.result}")
            else:
                print("模式切换成功")
        else:
            print("没有收到模式切换的反馈信息")
    except Exception as e:
        logging.error(f"Failed to switch mode: {e}")

# ARM飞机并切换模式
def arm_and_change_mode():
    try:
        # ARM飞机
        connection.mav.command_long_send(
            connection.target_system,
            connection.target_component,
            mavutil.mavlink.MAV_CMD_COMPONENT_ARM_DISARM,
            0, 1, 0, 0, 0, 0, 0, 0
        )
        logging.info("Sent ARM command to vehicle")

        # 切换到Mission模式
        set_px4_mode(connection, custom_mode=4)
        logging.info("Switched to Mission mode")
        time.sleep(5)

        # 切换到Position模式
        set_px4_mode(connection, custom_mode=3)
        logging.info("Switched to Position mode")
        time.sleep(1)

        # 切换到Offboard模式
        set_px4_mode(connection, custom_mode=6)
        logging.info("Switched to Offboard mode")

        # 开始发送Offboard模式的控制指令
        start_offboard_control(10)

        # 切回Mission模式
        set_px4_mode(connection, custom_mode=4)
        logging.info("Switched back to Mission mode")
    except Exception as e:
        logging.error(f"Failed to change modes: {e}")

# 在Offboard模式下发送控制指令
def start_offboard_control(duration):
    start_time = time.time()
    while time.time() - start_time < duration:
        center_x, center_y, area = get_latest_box_info()
        logging.info(f"Offboard control with x: {center_x}, y: {center_y}, z: {area}")
        connection.mav.set_position_target_local_ned_send(
            0,
            connection.target_system,
            connection.target_component,
            mavutil.mavlink.MAV_FRAME_LOCAL_NED,
            0b110111111000,
            center_x, center_y, -area,
            0, 0, 0, 0, 0, 0, 0
        )
        time.sleep(0.02)

# 启动线程和主逻辑
send_thread = threading.Thread(target=send_to_qgc)
receive_thread = threading.Thread(target=receive_from_qgc)
report_thread = threading.Thread(target=report_shared_values)

send_thread.start()
receive_thread.start()
report_thread.start()

# 程序启动时自动运行 arm_and_change_mode()
arm_and_change_mode()

try:
    send_thread.join()
    receive_thread.join()
    report_thread.join()
except KeyboardInterrupt:
    logging.info("Program interrupted, closing...")
finally:
    sock.close()
