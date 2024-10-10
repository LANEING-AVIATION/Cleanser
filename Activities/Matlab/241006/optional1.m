% 放射性废物处理问题的MATLAB代码

% 定义初始条件和常量
v0 = 0;                % 初始速度 ft/s
t0 = 0;                % 初始时间
t_final = 300;          % 目标时间
v_final = 45.1;         % 目标速度

% 设置常数项，假设一个简单的模型：dv/dt = -k*v + F
k = 0.05;              % 衰减系数，根据实际问题调整
F = 10;                % 外力影响，取决于环境的阻力或其他影响

% 定义微分方程
dvdt = @(t, v) -k * v + F;

% 使用ode45求解微分方程
[t, v] = ode45(dvdt, [t0, t_final], v0);

% 绘图展示速度变化
figure;
plot(t, v, 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Velocity (ft/s)');
title('Velocity vs Time in Radioactive Waste Treatment');
grid on;

% 检查t = 300时的速度
v_at_300 = interp1(t, v, 300);

% 输出结果
fprintf('At t = 300 seconds, the velocity is %.2f ft/s.\n', v_at_300);

% 验证是否满足 v(300) = 45.1 ft/s
if abs(v_at_300 - v_final) < 1e-2
    fprintf('The condition v(300) = 45.1 ft/s is satisfied.\n');
else
    fprintf('The condition v(300) = 45.1 ft/s is not satisfied.\n');
end

% 探讨改进方法：假设通过调整环境参数k或增加外力F来优化处理
k_new = 0.03;   % 新的衰减系数
F_new = 15;     % 新的外力

% 重新定义微分方程并求解
dvdt_new = @(t, v) -k_new * v + F_new;
[t_new, v_new] = ode45(dvdt_new, [t0, t_final], v0);

% 绘制改进后的结果
figure;
plot(t_new, v_new, 'r', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Velocity (ft/s)');
title('Improved Velocity vs Time in Radioactive Waste Treatment');
grid on;

% 输出改进后t = 300时的速度
v_at_300_new = interp1(t_new, v_new, 300);
fprintf('After improvement, at t = 300 seconds, the velocity is %.2f ft/s.\n', v_at_300_new);
