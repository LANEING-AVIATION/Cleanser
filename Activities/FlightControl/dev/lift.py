import rospy
from mavros_msgs.msg import PositionTarget
from geometry_msgs.msg import PoseStamped

def set_position(x, y, z):
    pos = PositionTarget()
    pos.coordinate_frame = PositionTarget.FRAME_LOCAL_NED
    pos.type_mask = PositionTarget.IGNORE_VX | PositionTarget.IGNORE_VY | PositionTarget.IGNORE_VZ | \
                    PositionTarget.IGNORE_AFX | PositionTarget.IGNORE_AFY | PositionTarget.IGNORE_AFZ | \
                    PositionTarget.IGNORE_YAW | PositionTarget.IGNORE_YAW_RATE
    pos.position.x = x
    pos.position.y = y
    pos.position.z = z
    return pos

def main():
    rospy.init_node('offboard_node', anonymous=True)
    pos_pub = rospy.Publisher('/mavros/setpoint_raw/local', PositionTarget, queue_size=10)
    rate = rospy.Rate(20)  # 20 Hz

    while not rospy.is_shutdown():
        pos = set_position(0, 0, 2)  # 让无人机上升到 2 米高度
        pos_pub.publish(pos)
        rate.sleep()

if __name__ == '__main__':
    try:
        main()
    except rospy.ROSInterruptException:
        pass
