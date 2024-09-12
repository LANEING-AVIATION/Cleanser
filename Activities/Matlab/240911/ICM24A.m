% 2024年全国大学生数学建模竞赛A题
% 问题一：板凳龙的运动学模型 - 龙头沿螺线运动，关节位置的计算

clear;
clc;
close all;

% 参数设定
v = 2; % 龙头的速度 (常数) 单位: m/s
a = 0.1; % 螺线的半径变化率 (m/rad)
r0 = 1; % 初始半径 (m)
d = 0.5; % 每个关节之间的距离 (m)
num_joints = 10; % 龙身关节数量
t_total = 20; % 总时间 (秒)
dt = 0.1; % 时间步长 (秒)
theta0 = 0; % 初始角度 (rad)

% 时间序列
t = 0:dt:t_total; % 从0秒到t_total秒，步长为dt
num_steps = length(t); % 时间步数量

% 初始化位置数组
x_head = zeros(1, num_steps);
y_head = zeros(1, num_steps);
x_joints = zeros(num_joints, num_steps);
y_joints = zeros(num_joints, num_steps);

% 龙头位置计算（沿螺线运动）
for i = 1:num_steps
    theta = theta0 + v * t(i); % 根据时间计算龙头当前角度
    r = r0 + a * theta; % 根据螺线方程计算半径
    x_head(i) = r * cos(theta); % 计算龙头在直角坐标系中的x坐标
    y_head(i) = r * sin(theta); % 计算龙头在直角坐标系中的y坐标
end

% 关节位置计算
for j = 1:num_joints
    for i = 1:num_steps
        offset_angle = theta0 + v * t(i) - (j-1) * (d / r0); % 偏移角度
        r = r0 + a * offset_angle; % 偏移角度对应的半径
        x_joints(j, i) = r * cos(offset_angle); % 计算每个关节的x坐标
        y_joints(j, i) = r * sin(offset_angle); % 计算每个关节的y坐标
    end
end

% 可视化
figure;
hold on;
plot(x_head, y_head, 'r', 'LineWidth', 2); % 绘制龙头的运动轨迹
for j = 1:num_joints
    plot(x_joints(j, :), y_joints(j, :), 'b--', 'LineWidth', 1); % 绘制每个关节的轨迹
end
legend('龙头轨迹', '关节轨迹');
xlabel('x 坐标 (m)');
ylabel('y 坐标 (m)');
title('龙头及关节的运动轨迹');
axis equal;
grid on;

% 可视化关节和龙头的位置随时间变化
figure;
hold on;
plot(t, sqrt(x_head.^2 + y_head.^2), 'r', 'LineWidth', 2); % 龙头的位置随时间变化
for j = 1:num_joints
    plot(t, sqrt(x_joints(j, :).^2 + y_joints(j, :).^2), '--', 'LineWidth', 1); % 关节的位置随时间变化
end
legend('龙头位置', '关节位置');
xlabel('时间 (s)');
ylabel('距离 (m)');
title('龙头及关节距离随时间变化');
grid on;
