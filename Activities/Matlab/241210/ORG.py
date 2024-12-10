import numpy as np
import matplotlib.pyplot as plt
from scipy.integrate import odeint

# 定义常数
g = 9.81  # 重力加速度 (m/s^2)
m = 70.0  # 运动员质量 (kg)
k = 5000  # 杆子的弹性常数 (N/m)
L = 5.0  # 杆子原始长度 (m)
x0 = 0  # 初始杆子压缩量 (m)
v0 = 8.5  # 运动员初速度 (m/s)
r0 = 1.5  # 运动员初始离地高度 (m)

# 初始条件：角度，速度，运动员初始位置
theta_0 = np.radians(10)  # 初始角度（10度）
omega_0 = 0  # 初始角速度
initial_conditions = [theta_0, omega_0]

# 计算杆子的弹性力
def spring_force(x):
    return k * x  # F = k * Δx, Δx是杆子的压缩量

# 计算每一时刻的运动状态
def equations(y, t):
    theta, omega = y
    # 计算杆子长度随角度变化的变化量
    L_t = L - r0 * np.cos(theta)  # 计算杆子的长度
    # 运动员的瞬心位置（沿着杆子的长度方向）
    r = L_t * np.sin(theta)
    
    # 计算杆子的弹性力
    spring_f = spring_force(L_t)
    
    # 计算运动员沿杆子的受力
    weight_f = m * g  # 运动员的重力
    
    # 运动员沿杆子的向心加速度
    centripetal_f = weight_f * r 
    
    # 根据守恒能量定理得出更新角度和角速度等方程
    equation_1 = spring_f - centripetal_f  # 状态方程

    # Update equation
    dtheta_dt = omega
    domega_dt = equation_1 / (m * g)

    return [dtheta_dt, domega_dt]

# 时间的范围
t = np.linspace(0, 10, 500)  # 时间范围

# 解动力学方程
solution = odeint(equations, initial_conditions, t)

# 可视化结果
plt.figure(figsize=(8, 8))

# 绘制钟面
theta_vals = np.linspace(0, 2 * np.pi, 100)
x_vals = L * np.cos(theta_vals)  # 钟面上的x坐标
y_vals = L * np.sin(theta_vals)  # 钟面上的y坐标
plt.plot(x_vals, y_vals, label='Clock Face', color='gray')

# 绘制运动员轨迹
for i in range(len(t)):
    theta = solution[i, 0]  # 当前角度
    # 计算当前角度下运动员的位置
    L_t = L - r0 * np.cos(theta)  # 当前杆子的长度
    x = L_t * np.cos(theta)  # 运动员的x坐标
    y = L_t * np.sin(theta)  # 运动员的y坐标
    plt.plot(x, y, 'bo', markersize=3)  # 绘制运动员的位置

# 标记运动员起始位置
plt.plot(L * np.cos(theta_0), L * np.sin(theta_0), 'go', label="Starting Point")

# 设置图形的轴
plt.axhline(0, color='black',linewidth=1)
plt.axvline(0, color='black',linewidth=1)
plt.xlim(-L, L)
plt.ylim(-L, L)
plt.gca().set_aspect('equal', adjustable='box')
plt.title("运动员沿着钟面运动的轨迹")
plt.xlabel('X (m)')
plt.ylabel('Y (m)')

plt.legend()
plt.grid(True)
plt.show()
