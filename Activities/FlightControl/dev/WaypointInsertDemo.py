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
        print(f"尝试切换到自定义模式: {custom_mode}")
        master.mav.command_long_send(
            master.target_system,
            master.target_component,
            mavutil.mavlink.MAV_CMD_DO_SET_MODE,
            0,
            base_mode,
            custom_mode,
            0, 0, 0, 0, 0
        )
    except Exception as e:
        print(f"模式切换失败: {str(e)}")

# 模拟遥控器控制飞行器
def simulate_rc_control(master):
    try:
        print("模拟遥控器控制飞行器")
        start_time = time.time()
        while time.time() - start_time < 5:  # 5秒内频繁发送信号
            # 打印发送的信号参数
            print("发送信号: 频道1=2000, 频道2=1500, 频道3=1500, 频道4=1500")
            master.mav.rc_channels_override_send(
                master.target_system,
                master.target_component,
                2000,  # 频道 1 (通常是滚转)
                1500,  # 频道 2 (通常是俯仰)
                2000,  # 频道 3 (通常是油门)
                1500,  # 频道 4 (通常是方向)
                0, 0, 0, 0  # 其他频道
            )
            time.sleep(0.01)  # 每10毫秒发送一次信号 (100Hz)
    except Exception as e:
        print(f"模拟遥控器失败: {str(e)}")

# 主程序
if __name__ == "__main__":
    master = connect()
    if master is not None:
        while True:
            if check_mode(master, expected_mode=67371008):
                print("飞控已进入模式 4，等待8秒后切换模式")
                time.sleep(8)
                set_px4_mode(master, custom_mode=3)
                simulate_rc_control(master)
                set_px4_mode(master, custom_mode=4)
                break
            else:
                print("飞控尚未进入模式 4，继续等待...")
            time.sleep(1)

        print("模式切换过程结束")
    else:
        print("飞控连接失败，无法继续操作")
