% 导入数据
data = readmatrix('alcohol_data.xlsx');

% 分离时间和酒精含量
time = data(1, :);         % 第一行：时间
alcohol_content = data(2, :); % 第二行：酒精含量

% 创建一个新图形窗口
figure;
hold on;

% 原始数据散点图
scatter(time, alcohol_content, 'filled', 'DisplayName', '原始数据');

% 线性插值
linear_interp_time = linspace(min(time), max(time), 100);
linear_interp = interp1(time, alcohol_content, linear_interp_time, 'linear');
plot(linear_interp_time, linear_interp, 'b-', 'LineWidth', 2, 'DisplayName', '线性插值');

% 样条插值
spline_interp = interp1(time, alcohol_content, linear_interp_time, 'spline');
plot(linear_interp_time, spline_interp, 'r-', 'LineWidth', 2, 'DisplayName', '样条插值');

% 分段常数插值
pchip_interp = interp1(time, alcohol_content, linear_interp_time, 'pchip');
plot(linear_interp_time, pchip_interp, 'g--', 'LineWidth', 2, 'DisplayName', '分段常数插值');

% 设置图形属性
xlabel('时间 (小时)');
ylabel('酒精含量 (毫克/百毫升)');
title('酒精含量与时间的插值');
grid on;

% 添加图例
legend('Location', 'Best');

hold off;

% 输出插值结果
disp('插值结果已绘制。');
