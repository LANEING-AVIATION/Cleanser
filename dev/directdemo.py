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
    
master = connect()

# 等待心跳包确认连接
master.wait_heartbeat()

# 设置模式为GUIDED
master.set_mode_auto()

# ARM电机
master.arducopter_arm()

# 起飞到指定高度
target_altitude = 10
master.mav.command_long_send(
    master.target_system, master.target_component,
    mavutil.mavlink.MAV_CMD_NAV_TAKEOFF,
    0, 0, 0, 0, 0, 0, 0, target_altitude)

# 等待起飞完成
master.motors_armed_wait()
master.motors_disarmed_wait()

# 发送航点
waypoints = [
    (37.7749, -122.4194, 10),  # 航点1
    (37.7750, -122.4195, 10)   # 航点2
]

for waypoint in waypoints:
    lat, lon, alt = waypoint
    master.mav.mission_item_send(
        master.target_system, master.target_component,
        0, mavutil.mavlink.MAV_FRAME_GLOBAL_RELATIVE_ALT,
        mavutil.mavlink.MAV_CMD_NAV_WAYPOINT, 0, 1, 0, 0, 0, 0,
        lat, lon, alt)

# 插入一个向右飞行的命令
right_distance = 10  # 向右飞行的距离（米）
master.mav.command_long_send(
    master.target_system, master.target_component,
    mavutil.mavlink.MAV_CMD_CONDITION_YAW,
    0, 90, 0, 1, 0, 0, 0, 0)  # 90度右转

# 等待右转完成
time.sleep(5)

# 继续执行航线
for waypoint in waypoints:
    lat, lon, alt = waypoint
    master.mav.mission_item_send(
        master.target_system, master.target_component,
        0, mavutil.mavlink.MAV_FRAME_GLOBAL_RELATIVE_ALT,
        mavutil.mavlink.MAV_CMD_NAV_WAYPOINT, 0, 1, 0, 0, 0, 0,
        lat, lon, alt)
