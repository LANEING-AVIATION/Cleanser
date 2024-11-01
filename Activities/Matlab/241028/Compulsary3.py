import numpy as np
from scipy.integrate import solve_ivp
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# 定义参数
a = 0.6
b = 2
c = 4

# 定义Rossler系统微分方程组
def rossler_system(t, Y):
    x, y, z = Y
    dxdt = -y - z
    dydt = x + a * y
    dzdt = b + z * (x - c)
    return [dxdt, dydt, dzdt]

# 初始条件和时间跨度
initial_conditions = [1, 0, 0]
t_span = (0, 10)   # 模拟时间范围
t_eval = np.linspace(t_span[0], t_span[1], 100)  # 为绘图设置时间点

# 求解微分方程组
solution = solve_ivp(rossler_system, t_span, initial_conditions, t_eval=t_eval)

# 提取结果
x = solution.y[0]
y = solution.y[1]
z = solution.y[2]

# 绘制三维相图
fig = plt.figure(figsize=(10, 7))
ax = fig.add_subplot(111, projection='3d')
ax.plot(x, y, z, lw=0.5)
ax.set_xlabel('x')
ax.set_ylabel('y')
ax.set_zlabel('z')
ax.set_title('Rossler')
plt.show()
