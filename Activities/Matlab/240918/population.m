clear
clc

% 数据
Y = [33815 33981 34004 34165 34212 34327 34344 34458 34498 34476 ...
     34483 34488 34513 34497 34511 34520 34507 34509 34521 34513 ...
     34515 34517 34519 34519 34521 34521 34523 34525 34525 34527];
T = 1:30;

% 初始化
x = zeros(1, 30);
y = zeros(1, 30);

% 计算 x(t) 和 y(t)
for t = 1:30
    x(t) = exp(-t);
    y(t) = 1 / Y(t);
end

% 构造 X 矩阵
c = ones(30, 1);  % 一列全是1
X = [c, x'];      % 组合成 X 矩阵

% 计算系数 B
B = inv(X' * X) * X' * y';

% 计算 z、s 和 w
z = zeros(1, 30);
s = zeros(1, 30);
w = zeros(1, 30);
y_mean = mean(y);

for i = 1:30
    z(i) = B(1) + B(2) * x(i);    % 预测值
    s(i) = y(i) - y_mean;         % 差值
    w(i) = z(i) - y(i);           % 残差
end

% 计算 S、Q、U、F
S = s * s';   % 差值平方和
Q = w * w';   % 残差平方和
U = S - Q;
F = 28 * U / Q;  % F值

% 输出结果
disp('B = ');
disp(B);
disp('F = ');
disp(F);

% 计算预测的 Y 值并与实际值比较
for j = 1:30
    predicted_Y = 1 / (B(1) + B(2) * exp(-j));
    disp(['Y(', num2str(j), ') - predicted Y = ', num2str(Y(j) - predicted_Y)]);
end

% 绘制图形
plot(T, Y, '-o');
xlabel('Time (T)');
ylabel('Population (Y)');
title('Population Over Time');
grid on;
