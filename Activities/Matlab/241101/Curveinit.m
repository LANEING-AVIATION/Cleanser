% 导入数据
data = readmatrix('alcohol_data.xlsx');

% 分离时间和酒精含量
time = data(1, :);         % 第一行：时间
alcohol_content = data(2, :); % 第二行：酒精含量

% 初始参数
initial_sigma = 0.9;
initial_x_scale = 3;
initial_y_scale = 130;

% 方差最小化
min_variance = Inf; % 初始化最小方差为无穷大
best_params = [initial_sigma, initial_x_scale, initial_y_scale]; % 存储最佳参数

% 迭代次数
iterations = 100; % 增加迭代次数

% 主循环进行参数调整
for i = 1:iterations
    % 随机生成新的参数
    test_sigma = initial_sigma + randn() * 0.1; % sigma 在 +/- 0.1 范围内波动
    test_x_scale = initial_x_scale + randn() * 0.5; % x_scale 在 +/- 0.5 范围内波动
    test_y_scale = initial_y_scale + randn() * 10; % y_scale 在 +/- 10 范围内波动
    
    % 生成 x 轴数据
    x_vals = linspace(0, 5, 100); % 从 0 到 5，100 个点
    
    % 计算对数正态分布概率密度函数
    pdf = (1 ./ (x_vals * test_sigma * sqrt(2 * pi))) .* ...
          exp(-((log(x_vals) - 0).^2) / (2 * test_sigma^2));
    
    % 对曲线进行缩放
    x_scaled = x_vals * test_x_scale;
    pdf_scaled = pdf * test_y_scale;
    
    % 计算拟合方差
    [~, idx] = min(abs(x_scaled' - time), [], 2); % 找到最近的索引
    fitted_values = pdf_scaled(idx); % 拟合值
    
    % 确保维度匹配
    if length(fitted_values) == length(alcohol_content)
        variance = sum((alcohol_content - fitted_values).^2); % 计算方差
        
        % 检查是否为最小方差
        if variance < min_variance
            min_variance = variance;
            best_params = [test_sigma, test_x_scale, test_y_scale];
        end
    end
end

% 输出最佳参数，精确到小数点后七位
optimized_sigma = best_params(1);
optimized_x_scale = best_params(2);
optimized_y_scale = best_params(3);

fprintf('优化后的参数:\n');
fprintf('Sigma: %.7f\n', optimized_sigma);
fprintf('X Scale: %.7f\n', optimized_x_scale);
fprintf('Y Scale: %.7f\n', optimized_y_scale);

% 绘制最终拟合结果
figure;
x_vals = linspace(0, 5, 100); % 从 0 到 5，100 个点
pdf = (1 ./ (x_vals * optimized_sigma * sqrt(2 * pi))) .* ...
      exp(-((log(x_vals) - 0).^2) / (2 * optimized_sigma^2));
x_scaled = x_vals * optimized_x_scale;
pdf_scaled = pdf * optimized_y_scale;

% 绘制原始数据
scatter(time, alcohol_content, 'filled', 'DisplayName', '原始数据');
hold on;

plot(x_scaled, pdf_scaled, 'LineWidth', 2, 'DisplayName', '拟合的对数正态分布');
title('优化后的对数正态分布曲线');
xlabel('X 轴');
ylabel('Y 轴');
grid on;
legend show;
xlim([0 7.5]); % 根据 x_scale 调整 x 轴范围
