
import tensorflow as tf
from PIL import Image
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.patches as patches

model = tf.lite.Interpreter(model_path="model.tflite")
classes = [  "cylinder" ,  ]


# Learn about its input and output details
input_details = model.get_input_details()
output_details = model.get_output_details()

model.resize_tensor_input(input_details[0]['index'], (1, 512, 512, 3))
model.allocate_tensors()


img = Image.open("image.jpg").convert('RGB')

if img.size[0] > img.size[1]:
    img = img.resize((512, 512 * img.size[1] // img.size[0] ), Image.ANTIALIAS)
else:
    img = img.resize((512 * img.size[0] // img.size[1], 512  ), Image.ANTIALIAS)

img_np = np.zeros((512,512,3)).astype('float32')
img_np[:img.size[1] , :img.size[0] ] = np.array(img)
img_np = img_np[None]

model.set_tensor(input_details[0]['index'], img_np)
model.invoke()

boxes = model.get_tensor(output_details[0]['index'])[0]
pred_cl = model.get_tensor(output_details[1]['index'])[0]

labels = pred_cl.argmax(-1)
scores = pred_cl.max(-1)


score_threshold = 0.8

indices = tf.image.non_max_suppression(
    boxes,
    scores,
    max_output_size=50,
    iou_threshold=0.2,
    score_threshold=0.6
).numpy()


boxes = boxes[indices]
labels = labels[indices]
scores = scores[indices]
class_names = [ classes[l] for l in labels]

fig, ax = plt.subplots()
ax.imshow(img_np[0].astype('uint8'))

for box, class_name in zip(boxes, class_names):
    ax.text(box[0], box[1], class_name, color='r')
    rect = patches.Rectangle((box[0], box[1]), box[2]-box[0], box[3]-box[1], linewidth=1, edgecolor='r', facecolor='none')
    ax.add_patch(rect)


plt.show()