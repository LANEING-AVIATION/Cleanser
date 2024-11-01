% 导入数据
data = readmatrix('alcohol_data.xlsx');

% 分离时间和酒精含量
time = data(1, :);         % 第一行：时间
alcohol_content = data(2, :); % 第二行：酒精含量

% 初始参数
initial_sigma = 0.9;
initial_x_scale = 3;
initial_y_scale = 130;

% 迭代次数
num_iterations = 1000;
best_mse = Inf; % 最佳均方误差
best_params = [initial_sigma, initial_x_scale, initial_y_scale];

% 存储初始拟合曲线
x_vals = linspace(0, 5, 100);
initial_pdf = (1 ./ (x_vals * initial_sigma * sqrt(2 * pi))) .* ...
               exp(-((log(x_vals) - 0).^2) / (2 * initial_sigma^2));
initial_x_scaled = x_vals * initial_x_scale;
initial_pdf_scaled = initial_pdf * initial_y_scale;

% 开始迭代
for i = 1:num_iterations
    % 随机波动参数
    sigma = initial_sigma + randn() * 0.1; % 在初始值附近波动
    x_scale = initial_x_scale + randn() * 0.5;
    y_scale = initial_y_scale + randn() * 5;

    % 生成拟合的对数正态分布
    pdf = (1 ./ (x_vals * sigma * sqrt(2 * pi))) .* ...
          exp(-((log(x_vals) - 0).^2) / (2 * sigma^2));
    x_scaled = x_vals * x_scale;
    pdf_scaled = pdf * y_scale;

    % 计算均方误差
    pdf_scaled_interp = interp1(x_scaled, pdf_scaled, time, 'linear', 0);
    mse = mean((alcohol_content - pdf_scaled_interp).^2);

    % 输出当前迭代参数
    fprintf('Iteration %d: sigma = %.3f, x_scale = %.3f, y_scale = %.3f, MSE = %.5f\n', ...
            i, sigma, x_scale, y_scale, mse);

    % 更新最佳参数
    if mse < best_mse
        best_mse = mse;
        best_params = [sigma, x_scale, y_scale];
    end
end

% 绘制最终拟合结果
figure;

% 最终参数
sigma_final = best_params(1);
x_scale_final = best_params(2);
y_scale_final = best_params(3);

% 生成最终拟合的对数正态分布
final_pdf = (1 ./ (x_vals * sigma_final * sqrt(2 * pi))) .* ...
             exp(-((log(x_vals) - 0).^2) / (2 * sigma_final^2));
final_x_scaled = x_vals * x_scale_final;
final_pdf_scaled = final_pdf * y_scale_final;

% 绘制原始数据和初始拟合曲线
scatter(time, alcohol_content, 'filled', 'DisplayName', '原始数据');
hold on;
plot(initial_x_scaled, initial_pdf_scaled, 'LineWidth', 1.5, 'DisplayName', '初始拟合曲线');

% 绘制最佳拟合曲线
plot(final_x_scaled, final_pdf_scaled, 'LineWidth', 2, 'DisplayName', '最终拟合曲线');

% 显示最终曲线表达式
%equation_text = sprintf('最终曲线: y = (1 / (x * %.3f * sqrt(2 * π))) * exp(-((log(x) - 0)^2) / (2 * %.3f^2)) * %.3f', sigma_final, sigma_final, y_scale_final);
%text(0.1, max(final_pdf_scaled)*0.8, equation_text, 'FontSize', 10, 'Color', 'red');

% 图形设置
title('酒精含量随时间变化曲线');
xlabel('时间');
ylabel('酒精含量');
grid on;
legend show;
xlim([0 18]);
hold off;
