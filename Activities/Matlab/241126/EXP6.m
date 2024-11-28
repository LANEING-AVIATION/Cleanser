% Newton插值法
% 数据
x = [0.40, 0.55, 0.65, 0.80, 0.90, 1.05]; % 给定x值
f = [0.41075, 0.57815, 0.69675, 0.88811, 1.02652, 1.25382]; % 对应f(x)值

% 1. 计算差商表
n = length(x);
div_diff = zeros(n, n); % 初始化差商表
div_diff(:, 1) = f'; % 第一列为f(x)

for j = 2:n
    for i = 1:n-j+1
        div_diff(i, j) = (div_diff(i+1, j-1) - div_diff(i, j-1)) / (x(i+j-1) - x(i));
    end
end

% 打印差商表
disp('差商表 (表6.5):');
disp(div_diff);

% 2. 计算f(0.596)的近似值
x_point = 0.596; % 给定的点
approx_value = div_diff(1, 1); % 插值多项式的初始值

product_term = 1; % 保存累积的乘积
for j = 1:n-1
    product_term = product_term * (x_point - x(j));
    approx_value = approx_value + div_diff(1, j+1) * product_term;
end

fprintf('f(%.3f)的近似值为: %.5f\n', x_point, approx_value);

% 3. 画出插值函数的图
% 构造插值多项式
syms z;
P = div_diff(1, 1); % 初始化多项式
product_term = 1;

for j = 1:n-1
    product_term = product_term * (z - x(j));
    P = P + div_diff(1, j+1) * product_term;
end

% 插值函数绘图
z_vals = linspace(min(x), max(x), 100); % x值范围
P_vals = double(subs(P, z, z_vals)); % 插值函数的值

figure;
plot(x, f, 'ro', 'MarkerSize', 8, 'DisplayName', '数据点');
hold on;
plot(z_vals, P_vals, 'b-', 'LineWidth', 1.5, 'DisplayName', '插值函数');
grid on;
legend;
xlabel('x');
ylabel('f(x)');
title('Newton插值法插值函数');

