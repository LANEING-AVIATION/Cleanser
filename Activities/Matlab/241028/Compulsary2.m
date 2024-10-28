% 定义初始条件和步长
x0 = 0; y0 = 1; h = 0.1;
x_end = 1; N = (x_end - x0) / h;

% 预分配空间
x = x0:h:x_end;
y_forward = zeros(1, N+1); y_improved = zeros(1, N+1);
y_forward(1) = y0; y_improved(1) = y0;

% 向前欧拉法
for i = 1:N
    y_forward(i+1) = y_forward(i) + h * (y_forward(i) - 2 * x(i) / y_forward(i));
end

% 改进欧拉法
for i = 1:N
    f = y_improved(i) - 2 * x(i) / y_improved(i);
    y_predictor = y_improved(i) + h * f;
    y_improved(i+1) = y_improved(i) + h / 2 * (f + (y_predictor - 2 * x(i+1) / y_predictor));
end

% 比较计算结果
plot(x, y_forward, 'b-o', x, y_improved, 'r-*');
legend('向前欧拉法', '改进欧拉法');
title('向前欧拉法与改进欧拉法的数值解');
xlabel('x');
ylabel('y');
grid on;
