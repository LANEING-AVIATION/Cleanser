% 导入数据
data = readmatrix('alcohol_data.xlsx');

% 分离时间和酒精含量
time = data(1, :);         % 第一行：时间
alcohol_content = data(2, :); % 第二行：酒精含量

% 创建一个新图形窗口
figure;
hold on;

% 线性拟合
linear_p = polyfit(time, alcohol_content, 1);
linear_fit = polyval(linear_p, time);
plot(time, linear_fit, 'b-', 'LineWidth', 2);
legend_text{1} = sprintf('线性拟合: y = %.2fx + %.2f', linear_p(1), linear_p(2));

% 二次拟合
quadratic_p = polyfit(time, alcohol_content, 2);
quadratic_fit = polyval(quadratic_p, time);
plot(time, quadratic_fit, 'r-', 'LineWidth', 2);
legend_text{2} = sprintf('二次拟合: y = %.2fx^2 + %.2fx + %.2f', quadratic_p(1), quadratic_p(2), quadratic_p(3));

% 指数拟合
exp_fit = fit(time', alcohol_content', 'exp1'); % 使用exp1表示y = a*exp(b*x)
plot(exp_fit, 'g-');
legend_text{3} = sprintf('指数拟合: y = %.2fe^{%.2fx}', exp_fit.a, exp_fit.b);

% 绘制原始数据
scatter(time, alcohol_content, 'filled');
xlabel('时间 (小时)');
ylabel('酒精含量 (毫克/百毫升)');
title('酒精含量与时间的关系');
grid on;

% 添加图例
legend(legend_text, 'Location', 'Best');

% 输出每种拟合的关系式
disp('线性拟合关系式:');
fprintf('y = %.2fx + %.2f\n', linear_p(1), linear_p(2));

disp('二次拟合关系式:');
fprintf('y = %.2fx^2 + %.2fx + %.2f\n', quadratic_p(1), quadratic_p(2), quadratic_p(3));

disp('指数拟合关系式:');
disp(sprintf('y = %.2fe^{%.2fx}', exp_fit.a, exp_fit.b));

hold off;
