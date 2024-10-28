% 定义符号变量
syms y(x)
% 定义微分方程
ode = diff(y, x) == y + 2*x;
% 初始条件
cond = y(0) == 1;
% 求解析解
sol = dsolve(ode, cond);

% 绘图
fplot(sol, [0, 1]);
title('解析解 y'' = y + 2x 的解图');
xlabel('x');
ylabel('y');
grid on;
disp('解析解为:');
disp(sol);
