% 2. 读取数据（此部分保持不变）
filename = 'pole_vault_data.xlsx';
opts = detectImportOptions(filename); 
data = readtable(filename, opts, 'Sheet', 1);

materials = data(:, 1:10);
density = materials{:, 2}; 
modulus = materials{:, 3}; 
strength = materials{:, 4}; 
inner_diameter = materials{:, 5}; 
outer_diameter = materials{:, 6}; 
grip_height = materials{:, 7}; 
weight = materials{:, 8}; 
time_to_peak = materials{:, 9}; 
efficiency = materials{:, 10}; 

% 3. 定义目标函数优化（返回标量）
function f = optimization_function(x, density, modulus, strength, inner_diameter, outer_diameter, grip_height, weight, time_to_peak, efficiency)
    % 提取优化参数
    opt_density = x(1);
    opt_modulus = x(2);
    opt_strength = x(3);
    opt_inner_diameter = x(4);
    opt_outer_diameter = x(5);
    opt_grip_height = x(6);
    
    % 假设的计算
    E = opt_modulus * 1e9; % GPa 转换为 Pa
    I = (pi / 64) * (opt_outer_diameter^4 - opt_inner_diameter^4) * 1e-12; % 假设截面为圆形
    P = weight * 9.81; % 重力作用下的力
    L = 5.85; % 杆子长度，单位米

    % 使用简化的弯曲公式计算挠度
    deflection = (P * L^3) / (3 * E * I);  % 挠度公式，简化形式

    % 假设目标是挠度最小化，效率作为一个附加项来加权
    f = deflection - 0.01 * (efficiency - 80);  % 80%效率作为目标，进行加权调整
end

% 4. 定义粒子群优化（PSO）
optim_func = @(x) optimization_function(x, density, modulus, strength, inner_diameter, outer_diameter, grip_height, weight, time_to_peak, efficiency);
options = optimoptions('particleswarm', 'SwarmSize', 100, 'MaxIterations', 200);
[optimal_params, fval] = particleswarm(optim_func, 6, [0 0 0 0 0 0], [3000 3000 3000 100 100 3]);

% 输出结果
best_density = optimal_params(1);
best_modulus = optimal_params(2);
best_strength = optimal_params(3);
best_inner_diameter = optimal_params(4);
best_outer_diameter = optimal_params(5);
best_grip_height = optimal_params(6);

fprintf('Optimal Material Density: %.2f kg/m³\n', best_density);
fprintf('Optimal Material Modulus: %.2f GPa\n', best_modulus);
fprintf('Optimal Material Strength: %.2f MPa\n', best_strength);
fprintf('Optimal Inner Diameter: %.2f mm\n', best_inner_diameter);
fprintf('Optimal Outer Diameter: %.2f mm\n', best_outer_diameter);
fprintf('Optimal Grip Height: %.2f m\n', best_grip_height);

% 5. 计算最优杆子的运动轨迹并绘制
% 这里假设的轨迹是基于计算出的物理特性来获得的
% 具体计算可以根据实际物理模型进行调整

time_intervals = diff(time_to_peak);
highest_point_coords = calculate_trajectory(best_density, best_modulus, best_strength, best_inner_diameter, best_outer_diameter, best_grip_height, coordinates);

% 绘制运动轨迹
figure;
plot(highest_point_coords(:, 1), highest_point_coords(:, 2));
title('Optimized Pole Vault Trajectory');
xlabel('X (m)');
ylabel('Y (m)');
grid on;

