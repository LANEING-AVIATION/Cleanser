% 定义x的范围
x = -2:0.01:2;

% 定义四个函数
y1 = exp(x);
y2 = 1 + x;
y3 = 1 + x + (1/2) * (x.^2);
y4 = 1 + x + (1/2) * (x.^2) + (1/6) * (x.^3);

% 在同一坐标系中绘制四条曲线
figure;
plot(x, y1, 'r', 'LineWidth', 1.5); hold on;
plot(x, y2, 'g', 'LineWidth', 1.5);
plot(x, y3, 'b', 'LineWidth', 1.5);
plot(x, y4, 'm', 'LineWidth', 1.5);
legend('y1 = e^x', 'y2 = 1 + x', 'y3 = 1 + x + (1/2) * x^2', 'y4 = 1 + x + (1/2) * x^2 + (1/6) * x^3');
xlabel('x'); ylabel('y');
title('Four Curves on the Same Plot');
grid on;

% 使用subplot分别绘制四条曲线
figure;

subplot(2, 2, 1);
plot(x, y1, 'r', 'LineWidth', 1.5);
title('y1 = e^x');
xlabel('x'); ylabel('y');
grid on;

subplot(2, 2, 2);
plot(x, y2, 'g', 'LineWidth', 1.5);
title('y2 = 1 + x');
xlabel('x'); ylabel('y');
grid on;

subplot(2, 2, 3);
plot(x, y3, 'b', 'LineWidth', 1.5);
title('y3 = 1 + x + (1/2) * x^2');
xlabel('x'); ylabel('y');
grid on;

subplot(2, 2, 4);
plot(x, y4, 'm', 'LineWidth', 1.5);
title('y4 = 1 + x + (1/2) * x^2 + (1/6) * x^3');
xlabel('x'); ylabel('y');
grid on;
