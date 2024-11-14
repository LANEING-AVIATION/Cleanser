% 初始条件
epsilon = 1e-7;
xk = 0.7;

% 定义函数和导数
f = @(x) x * sin(x) - 0.5;
f_prime = @(x) sin(x) + x * cos(x);

% Newton 迭代
while true
    xk_next = xk - f(xk) / f_prime(xk)  % Newton 公式
    if abs(xk_next - xk) < epsilon       % 检查误差限
        break;
    end
    xk = xk_next;
end

% 输出结果
fprintf('根的近似值为: %.10f\n', xk_next);
