import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# 定义网格
x = np.arange(-8, 8, 0.5)
y = np.arange(-8, 8, 0.5)
X, Y = np.meshgrid(x, y)

# 定义函数 z = sin(r)/r
r = np.sqrt(X**2 + Y**2) + np.finfo(float).eps  # 添加一个小常数以避免除以零
Z = np.sin(r) / r

# 创建图形
fig = plt.figure(figsize=(10, 7))
ax = fig.add_subplot(111, projection='3d')
surf = ax.plot_surface(X, Y, Z, edgecolor='none', cmap='viridis')

# 隐藏坐标轴
ax.axis('off')

# 添加光照效果
ax.view_init(elev=30, azim=210)  # 设置视角
plt.colorbar(surf)  # 添加色条

# 添加标题
ax.set_title('MATLAB Welcome')

# 保存图形
plt.savefig('/mnt/d/GitHubRepo/LANEING/Cleanser/Activities/Machine_Learning/Outcome/matlab_icon_surface_plot.png', bbox_inches='tight')
plt.close()
