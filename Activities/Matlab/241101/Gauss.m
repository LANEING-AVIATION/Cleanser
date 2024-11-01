% 导入数据
data = readmatrix('alcohol_data.xlsx');

% 分离时间和酒精含量
time = data(1, :);         % 第一行：时间
alcohol_content = data(2, :); % 第二行：酒精含量

% 创建一个新图形窗口
figure;
hold on;

% 绘制原始数据
scatter(time, alcohol_content, 'filled', 'DisplayName', '原始数据');

% 双高斯函数定义
double_gauss_fit = @(b, x) ...
    b(1) * exp(-((x - b(2)).^2) / (2 * b(3)^2)) + ...
    b(4) * exp(-((x - b(5)).^2) / (2 * b(6)^2));

% 初始猜测参数 [峰值1, 中心位置1, 宽度1, 峰值2, 中心位置2, 宽度2]
initial_params = [max(alcohol_content), mean(time), std(time), ...
                  max(alcohol_content) * 0.1, mean(time) + 1, std(time) * 2];

% 最小化平方差
options = optimset('Display', 'off');
fit_params = lsqcurvefit(double_gauss_fit, initial_params, time, alcohol_content, [], [], options);

% 生成拟合曲线
fit_time = linspace(min(time), max(time), 100);
fit_alcohol_content = double_gauss_fit(fit_params, fit_time);

% 绘制拟合曲线
plot(fit_time, fit_alcohol_content, 'r-', 'LineWidth', 2, 'DisplayName', '双高斯拟合');

% 设置图形属性
xlabel('时间 (小时)');
ylabel('酒精含量 (毫克/百毫升)');
title('酒精含量与时间的双高斯拟合');
grid on;

% 添加图例
legend('Location', 'Best');

hold off;

% 输出拟合参数
disp('双高斯拟合参数:');
disp(fit_params);

% 正确的拟合关系式输出
fprintf('拟合关系式: y = %.2f * exp(-((x - %.2f)^2) / (2 * %.2f^2)) + %.2f * exp(-((x - %.2f)^2) / (2 * %.2f^2)\n', ...
    fit_params(1), fit_params(2), fit_params(3), ...
    fit_params(4), fit_params(5), fit_params(6));
