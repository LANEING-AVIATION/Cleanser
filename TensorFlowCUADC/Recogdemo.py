import rospy
import tensorflow as tf
from sensor_msgs.msg import Image as RosImage
from cv_bridge import CvBridge
import cv2
import numpy as np

# Initialize TensorFlow model and class names
model = tf.saved_model.load('./')
classes = ["cylinder"]

# Create a CvBridge instance for ROS-OpenCV conversion
bridge = CvBridge()

# Define the score threshold for filtering
score_threshold = 0.8

# Callback function to process the image
def image_callback(msg):
    # Convert ROS Image message to OpenCV image
    cv_img = bridge.imgmsg_to_cv2(msg, "rgb8")
    
    # Resize image while maintaining aspect ratio
    if cv_img.shape[1] > cv_img.shape[0]:
        resized_img = cv2.resize(cv_img, (512, 512 * cv_img.shape[0] // cv_img.shape[1]))
    else:
        resized_img = cv2.resize(cv_img, (512 * cv_img.shape[1] // cv_img.shape[0], 512))
    
    # Prepare the image for model input (shape: [1, 512, 512, 3])
    img_np = np.zeros((512, 512, 3), dtype='float32')
    img_np[:resized_img.shape[0], :resized_img.shape[1]] = resized_img / 255.0
    img_np = np.expand_dims(img_np, axis=0)
    
    # Perform inference
    inp = tf.constant(img_np, dtype=tf.float32)
    [boxes, pred_cl] = model(inp)
    
    # Convert predictions to numpy arrays
    boxes = boxes[0].numpy()
    pred_cl = pred_cl[0].numpy()
    
    # Get labels and scores
    labels = pred_cl.argmax(-1)
    scores = pred_cl.max(-1)
    
    # Apply non-max suppression
    indices = tf.image.non_max_suppression(
        boxes,
        scores,
        max_output_size=50,
        iou_threshold=0.2,
        score_threshold=0.6
    ).numpy()
    
    # Filter the boxes, labels, and scores based on NMS
    boxes = boxes[indices]
    labels = labels[indices]
    scores = scores[indices]
    
    # If there are any detections, print the coordinates of the first one
    if len(boxes) > 0:
        first_box = boxes[0]  # Get the first detected box
        print(f"Detected object bounds (xmin, ymin, xmax, ymax): {first_box}")

# Initialize the ROS node
rospy.init_node('object_detection_node')

# Subscribe to the camera image topic
image_sub = rospy.Subscriber('/iris/camera/image_raw', RosImage, image_callback)

# Keep the node running
rospy.spin()
