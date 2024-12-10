import numpy as np
import pandas as pd
from scipy.optimize import differential_evolution
import matplotlib.pyplot as plt
from scipy.interpolate import interp1d

# 1. 读取数据
filename = 'D:\\GitHubRepo\\LANEING\\Cleanser\\Activities\\Matlab\\241210\\pole_vault_data.xlsx'
# 读取材料特性数据（sheet1）
materials = pd.read_excel(filename, sheet_name='Sheet1')

# 提取数据
density = materials['density'].values
modulus = materials['modulus'].values
strength = materials['strength'].values
inner_diameter = materials['inner'].values
outer_diameter = materials['outer'].values
grip_height = materials['grip'].values
weight = materials['weight'].values
time_to_peak = materials['peak'].values
efficiency = materials['efficiency'].values

# 读取杆子运动轨迹数据（sheet2, sheet3, sheet4）
trajectory_fiber_data = pd.read_excel(filename, sheet_name='Sheet2', header=None).values
trajectory_glass_data = pd.read_excel(filename, sheet_name='Sheet3', header=None).values
trajectory_aluminum_data = pd.read_excel(filename, sheet_name='Sheet4', header=None).values

# 提取每种材料的X和Y坐标（运动轨迹）
x_fiber, y_fiber = trajectory_fiber_data[:, 0], trajectory_fiber_data[:, 1]
x_glass, y_glass = trajectory_glass_data[:, 0], trajectory_glass_data[:, 1]
x_aluminum, y_aluminum = trajectory_aluminum_data[:, 0], trajectory_aluminum_data[:, 1]

# 2. 计算最长的轨迹长度
max_len = max(len(x_fiber), len(x_glass), len(x_aluminum))

# 3. 插值：将三个轨迹数据扩展到相同的长度
def interpolate_trajectory(x, y, new_length):
    # 创建插值函数
    interp_func = interp1d(x, y, kind='cubic', fill_value="extrapolate")
    # 创建新的x坐标
    new_x = np.linspace(x[0], x[-1], new_length)
    # 计算插值后的y值
    new_y = interp_func(new_x)
    return new_x, new_y

# 将每个轨迹扩展到相同的长度
x_fiber_resampled, y_fiber_resampled = interpolate_trajectory(x_fiber, y_fiber, max_len)
x_glass_resampled, y_glass_resampled = interpolate_trajectory(x_glass, y_glass, max_len)
x_aluminum_resampled, y_aluminum_resampled = interpolate_trajectory(x_aluminum, y_aluminum, max_len)

# 4. 定义目标函数优化
def optimization_function(x):
    # 提取优化参数
    opt_density = x[0]
    opt_modulus = x[1]
    opt_strength = x[2]
    opt_inner_diameter = x[3]
    opt_outer_diameter = x[4]
    opt_grip_height = x[5]

    # 假设的计算
    E = opt_modulus * 1e9  # GPa 转换为 Pa
    I = (np.pi / 64) * (opt_outer_diameter**4 - opt_inner_diameter**4) * 1e-12  # 假设截面为圆形
    P = weight * 9.81  # 重力作用下的力
    L = 5.85  # 杆子长度，单位米

    # 使用简化的弯曲公式计算挠度
    deflection = (P * L**3) / (3 * E * I)  # 挠度公式，简化形式

    # 5. 基于已有的轨迹数据进行插值（假设新材料的参数位于这三种材料之间）
    # 我们将根据密度进行加权插值
    densities = np.array([1580, 1990, 2768])  # 碳纤维、玻璃纤维、铝的密度
    y_values = np.array([y_fiber_resampled, y_glass_resampled, y_aluminum_resampled])  # 三种材料的y轨迹数据

    # 使用插值方法
    new_density = opt_density  # 优化得到的新密度
    weights = np.array([np.abs(d - new_density) for d in densities])  # 基于距离密度的权重
    weights = weights / np.sum(weights)  # 权重归一化

    # 通过加权平均方式进行轨迹插值
    interpolated_y = np.sum(weights[:, None] * y_values, axis=0)  # 对y进行加权插值
    interpolated_x = x_fiber_resampled  # 假设x坐标相同，使用碳纤维的x坐标

    # 计算跳跃高度：插值后的轨迹最大值
    highest_point = np.max(interpolated_y)

    # 目标函数是跳跃高度减去一些惩罚项
    f = -highest_point + 0.01 * (np.mean(efficiency) - 80)  # 80%效率作为目标，进行加权调整

    return f

# 6. 定义粒子群优化（PSO）参数
# 定义参数的范围
bounds = [(1500, 2500), (50, 200), (300, 1200), (30, 40), (30, 40), (4, 6)]  # 定义参数的范围
result = differential_evolution(optimization_function, bounds, maxiter=200, popsize=100)

optimal_params = result.x
fval = result.fun

# 输出结果
best_density = optimal_params[0]
best_modulus = optimal_params[1]
best_strength = optimal_params[2]
best_inner_diameter = optimal_params[3]
best_outer_diameter = optimal_params[4]
best_grip_height = optimal_params[5]

print(f'Optimal Material Density: {best_density:.2f} kg/m³')
print(f'Optimal Material Modulus: {best_modulus:.2f} GPa')
print(f'Optimal Material Strength: {best_strength:.2f} MPa')
print(f'Optimal Inner Diameter: {best_inner_diameter:.2f} mm')
print(f'Optimal Outer Diameter: {best_outer_diameter:.2f} mm')
print(f'Optimal Grip Height: {best_grip_height:.2f} m')

# 7. 计算最优杆子的运动轨迹并绘制
# 计算并绘制最优轨迹
def calculate_interpolated_trajectory(opt_density):
    # 使用最优密度插值得到新轨迹
    densities = np.array([1580, 1990, 2768])  # 碳纤维、玻璃纤维、铝的密度
    y_values = np.array([y_fiber_resampled, y_glass_resampled, y_aluminum_resampled])  # 三种材料的y轨迹数据

    # 使用插值方法
    weights = np.array([np.abs(d - opt_density) for d in densities])  # 基于密度的权重
    weights = weights / np.sum(weights)  # 权重归一化

    # 通过加权平均方式进行轨迹插值
    interpolated_y = np.sum(weights[:, None] * y_values, axis=0)  # 对y进行加权插值
    interpolated_x = x_fiber_resampled  # 假设x坐标相同，使用碳纤维的x坐标

    return interpolated_x, interpolated_y

# 计算最优设计下的轨迹
interpolated_x, interpolated_y = calculate_interpolated_trajectory(best_density)

# 绘制最优轨迹
plt.figure()
plt.plot(interpolated_x, interpolated_y)
plt.title('Optimized Pole Vault Trajectory (Interpolated)')
plt.xlabel('X (m)')
plt.ylabel('Y (m)')
plt.grid(True)
plt.show()
