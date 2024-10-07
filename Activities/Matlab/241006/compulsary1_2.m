f = @(x) x^5 + 5*x^3 - 2*x + 1;
df = @(x) 5*x^4 + 15*x^2 - 2; % 导数
x0 = 0; % 初始值
tol = 1e-6; % 收敛容忍度
max_iter = 100; % 最大迭代次数

for iter = 1:max_iter
    x1 = x0 - f(x0)/df(x0);
    if abs(x1 - x0) < tol
        break;
    end
    x0 = x1;
end
disp(x1);
