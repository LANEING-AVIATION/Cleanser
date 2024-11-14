% 初始值和误差限
x0 = 0.5;
x1 = 1;
epsilon = 1e-7;

% 定义函数
f = @(x) x * sin(x) - 0.5;

% 初始化迭代
k = 1;
xk_1 = x0;
xk = x1;

% 开始迭代
while abs(f(xk)) > epsilon
    % 应用迭代公式
    xk_plus_1 = xk - (xk - xk_1) * f(xk) / (f(xk) - f(xk_1));
    
    % 更新变量
    xk_1 = xk;
    xk = xk_plus_1;
    
    % 输出每一步的计算结果
    fprintf('Iteration %d: x = %.8f, f(x) = %.8f\n', k, xk, f(xk));
    
    k = k + 1;
end

% 输出结果
fprintf('根的近似解为: x = %.8f, f(x) = %.8f\n', xk, f(xk));
