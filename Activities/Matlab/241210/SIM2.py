import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy.interpolate import interp1d

#输入初始数据
user_modulus = float(input("弹性模量 (GPa): "))
user_grip_height = float(input("杆长 (m): "))
user_weight = float(input("杆的重量 (kg): "))
user_height=float(input("运动员身高(m):"))
user_renweight=float(input("输入运动员体重(kg):"))

# 2. 读取数据
filename = 'D:\\GitHubRepo\\LANEING\\Cleanser\\Activities\\Matlab\\241210\\pole_vault_data2.xlsx'
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
x_fiber, y_fiber = trajectory_fiber_data[:, 2], trajectory_fiber_data[:, 3]
x_glass, y_glass = trajectory_glass_data[:, 2], trajectory_glass_data[:, 3]
x_aluminum, y_aluminum = trajectory_aluminum_data[:, 2], trajectory_aluminum_data[:, 3]

# 3. 计算最长的轨迹长度
max_len = max(len(x_fiber), len(x_glass), len(x_aluminum))

# 4. 插值：将三个轨迹数据扩展到相同的长度
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

# 5. 基于用户输入的modulus, grip height 和 weight 计算加权值，并进行插值
def calculate_trajectory(user_modulus, user_grip_height, user_weight):
    # 对三个输入参数进行标准化
    print (modulus)
    modulus_scaled = (user_modulus - np.min(modulus)) / (np.max(modulus) - np.min(modulus))
    grip_height_scaled = (user_grip_height - np.min(grip_height)) / (np.max(grip_height) - np.min(grip_height))
    weight_scaled = (user_weight - np.min(weight)) / (np.max(weight) - np.min(weight))

    # 计算加权值（可以按比例加权，或者根据需要调整权重的影响）
    weights = np.array([modulus_scaled, grip_height_scaled, weight_scaled])
    weights = weights / np.sum(weights)  # 权重归一化

    # 将三个轨迹数据进行加权插值
    y_values = np.array([y_fiber_resampled, y_glass_resampled, y_aluminum_resampled])  # 三种材料的y轨迹数据

    interpolated_y = (np.sum(weights[:, None] * y_values, axis=0) -1.75+user_height)/75*user_renweight# 对y进行加权插值
    interpolated_x = x_fiber_resampled -2# 假设x坐标相同，使用碳纤维的x坐标

    # 计算跳跃高度：插值后的轨迹最大值
    highest_point = np.max(interpolated_y)
    
    return interpolated_x, interpolated_y, highest_point

# 使用用户输入的参数计算运动轨迹
interpolated_x, interpolated_y, highest_point = calculate_trajectory(
    user_modulus, user_grip_height, user_weight)

# 6. 绘制运动轨迹
plt.figure()
plt.plot(interpolated_x, interpolated_y, label=f"Trajectory (Modulus: {user_modulus} GPa, Length: {user_grip_height} m, Weight: {user_weight} kg)")
plt.title('Pole Vault Trajectory (User-defined Parameters)')
plt.xlabel('X (m)')
plt.ylabel('Y (m)')
plt.legend()
plt.grid(True)
plt.show()

print(f"最大跳跃高度: {highest_point} 米")
