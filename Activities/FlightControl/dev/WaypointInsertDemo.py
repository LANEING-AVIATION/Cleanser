from pymavlink import mavutil
import time

# 连接到已经连接飞控的MAVLink实例
def connect():
    try:
        print("正在连接到已连接的PX4飞控...")
        master = mavutil.mavlink_connection('udp:127.0.0.1:14550')  # 修改为你的MAVLink连接地址
        master.wait_heartbeat()
        print("飞控连接成功")
        return master
    except Exception as e:
        print(f"连接失败: {str(e)}")
        return None

# 检查飞控当前模式是否为指定模式
def check_mode(master, expected_mode):
    try:
        # 请求飞控状态信息
        msg = master.recv_match(type='HEARTBEAT', blocking=True, timeout=5)
        if msg:
            current_mode = msg.custom_mode
            print(f"当前模式: {current_mode}")
            if current_mode == expected_mode:
                print(f"当前模式等于 {expected_mode}，可以继续操作")
                return True
            else:
                print(f"当前模式不是 {expected_mode}，继续等待")
                return False
        else:
            print("未能接收到心跳信息")
            return False
    except Exception as e:
        print(f"获取当前模式失败: {str(e)}")
        return False

# 强制切换到指定的飞行模式
def set_px4_mode(master, custom_mode, base_mode=mavutil.mavlink.MAV_MODE_FLAG_CUSTOM_MODE_ENABLED):
    try:
        print(f"尝试切换到自定义模式: {custom_mode} ")
        master.mav.command_long_send(
            master.target_system,  # 目标系统 ID
            master.target_component,  # 目标组件 ID
            mavutil.mavlink.MAV_CMD_DO_SET_MODE,  # 切换模式命令
            0,  # 确认标志位
            base_mode,  # 基本飞行模式标志
            custom_mode,  # 自定义飞行模式 (Position 模式为 3)
            0, 0, 0, 0, 0  # 其他参数留空
        )

        # 等待一小段时间，检查模式是否切换成功
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
        print(f"模式切换失败: {str(e)}")

# 主程序
if __name__ == "__main__":
    master = connect()
    if master is not None:
        # 不断检测是否处于模式4 (已解锁)
        while True:
            if check_mode(master, expected_mode = 67371008):
                print("飞控已进入模式 4，等待8秒后切换模式")
                time.sleep(8)
                # 切换模式
                set_px4_mode(master, custom_mode=3)

                #修改这里的代码，插入waypoint飞向经纬度(200，200)

                time.sleep(2)

                set_px4_mode(master, custom_mode=4)
                break
            else:
                print("飞控尚未进入模式 4，继续等待...")
            time.sleep(1)  # 每秒检测一次

        print("模式切换过程结束")
    else:
        print("飞控连接失败，无法继续操作")