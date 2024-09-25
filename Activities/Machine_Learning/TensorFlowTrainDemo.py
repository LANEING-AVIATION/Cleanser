import tensorflow as tf
from tensorflow.keras import datasets, layers, models
import os

# Uncomment if you want to disable GPU
# os.environ["CUDA_VISIBLE_DEVICES"] = "-1"

# 下载 Fashion MNIST 数据集
(x_train, y_train), (x_test, y_test) = datasets.fashion_mnist.load_data()

# 数据预处理
x_train = x_train.astype("float32") / 255.0
x_test = x_test.astype("float32") / 255.0

# 添加通道维度
x_train = x_train[..., tf.newaxis]
x_test = x_test[..., tf.newaxis]

# 创建卷积神经网络模型
model = models.Sequential([
    layers.Conv2D(32, (3, 3), activation='relu', input_shape=(28, 28, 1)),
    layers.MaxPooling2D((2, 2)),
    layers.Conv2D(64, (3, 3), activation='relu'),
    layers.MaxPooling2D((2, 2)),
    layers.Conv2D(64, (3, 3), activation='relu'),
    layers.Flatten(),
    layers.Dense(64, activation='relu'),
    layers.Dense(10)  # 10 类别
])

# 编译模型
model.compile(optimizer='adam',
              loss=tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True),
              metrics=['accuracy'])

# 训练模型
model.fit(x_train, y_train, epochs=10, validation_data=(x_test, y_test))

# 修改为保存为新的Keras格式
model.save('my_model.keras')
