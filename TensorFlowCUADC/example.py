import tensorflow as tf
import numpy as np
import rospy
from sensor_msgs.msg import Image
from cv_bridge import CvBridge
import cv2
import sys

# 禁用所有可用的GPU
tf.config.set_visible_devices([], 'GPU')

# 设置环境变量以禁止显示TensorFlow的日志信息
import os
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '2'  # '2'表示仅显示错误信息，不显示警告信息

# 设置TensorFlow的日志级别
import logging
tf.get_logger().setLevel(logging.ERROR)

# 加载模型
model = tf.saved_model.load('./')

# 定义类别
classes = ["cylinder"]

# 初始化ROS节点
rospy.init_node('object_detection_node')

# 初始化CV桥接
bridge = CvBridge()

# 图像回调函数
def image_callback(img_msg):
    # 转换ROS图像消息为OpenCV图像
    try:
        img = bridge.imgmsg_to_cv2(img_msg, "bgr8")
    except Exception as e:
        rospy.logerr(f"Failed to convert ROS image to OpenCV image: {e}")
        return

    # 处理图像
    img = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)

    # 调整图像大小
    h, w, _ = img.shape
    if w > h:
        img = cv2.resize(img, (512, 512 * h // w))
    else:
        img = cv2.resize(img, (512 * w // h, 512))

    img_np = np.zeros((512, 512, 3)).astype('float32')
    img_np[:img.shape[0], :img.shape[1]] = img
    img_np = img_np[None]

    # 创建 TensorFlow 常量
    inp = tf.constant(img_np, dtype='float32')

    # 推理
    boxes, pred_cl = model(inp)

    # 转换为 numpy 数组
    boxes = boxes[0].numpy()
    pred_cl = pred_cl[0].numpy()

    # 处理检测结果
    labels = pred_cl.argmax(-1)
    scores = pred_cl.max(-1)

    # 设定阈值
    score_threshold = 0.8

    # 执行非极大值抑制
    indices = tf.image.non_max_suppression(
        boxes,
        scores,
        max_output_size=50,
        iou_threshold=0.2,
        score_threshold=score_threshold
    ).numpy()

    # 选择最终的检测框
    boxes = boxes[indices]
    labels = labels[indices]
    scores = scores[indices]
    class_names = [classes[l] for l in labels]

    # 输出结果
    for box, class_name in zip(boxes, class_names):
        x1, y1, x2, y2 = box
        print(f"Detected {class_name} with coordinates: ({x1:.2f}, {y1:.2f}), ({x2:.2f}, {y2:.2f})")

# 订阅ROS话题
image_sub = rospy.Subscriber("/iris/camera/image_raw", Image, image_callback)

# 运行ROS循环
rospy.spin()
