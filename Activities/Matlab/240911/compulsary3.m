% 牛顿迭代法求方程 x^2 - 2 = 0 的一个根
% 迭代终止条件为前后两次求出的 x 的差的绝对值小于 10^-5

% 初始化
x = 1; % 初始猜测
tolerance = 1e-5; % 终止条件
diff = 1; % 用于存储前后两次x的差值
max_iterations = 100; % 设置最大迭代次数
iteration = 0; % 记录迭代次数

% 迭代过程
while diff > tolerance && iteration < max_iterations
    x_new = x - (x^2 - 2) / (2 * x); % 牛顿迭代公式
    diff = abs(x_new - x); % 计算前后两次 x 的差值
    x = x_new; % 更新 x
    iteration = iteration + 1; % 更新迭代次数
end

% 输出结果
fprintf('经过 %d 次迭代，方程的一个根为: %.6f\n', iteration, x);
