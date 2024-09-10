
import tensorflow
from PIL import Image
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.patches as patches

model = tensorflow.saved_model.load('./')
classes = [  "cylinder" ,  ]

img = Image.open("image.jpg").convert('RGB')

if img.size[0] > img.size[1]:
    img = img.resize((512, 512 * img.size[1] // img.size[0] ), Image.ANTIALIAS)
else:
    img = img.resize((512 * img.size[0] // img.size[1], 512  ), Image.ANTIALIAS)

img_np = np.zeros((512,512,3)).astype('float32')
img_np[:img.size[1] , :img.size[0] ] = np.array(img)
img_np = img_np[None]

inp = tensorflow.constant(img_np, dtype='float32')

[boxes, pred_cl] = model(inp)

boxes = boxes[0].numpy()
pred_cl = pred_cl[0].numpy()

labels = pred_cl.argmax(-1)
scores = pred_cl.max(-1)


score_threshold = 0.8

indices = tensorflow.image.non_max_suppression(
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