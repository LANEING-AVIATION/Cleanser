% 计算定积分，x的平方 加 3x 加 2，区间 0-1
syms x;
result = int(x^2 + 3*x + 2, x, 0, 1);
disp(result);