% 定义目标函数
function z = objective(x)
    % 目标函数定义为负数，因为fmincon最小化
    z = -0.201 * (x(1)^4) * (x(2)) * (x(3)^2) / (10^7); 
end

% 定义约束条件
function [c, ceq] = constraints(x)
    c(1) = (x(1)^2) * (x(2)) - 675; % 675 - (x1^2) * (x2) >= 0
    c(2) = (x(1)^2) * (x(3)^2) / (10^7) - 0.419; % 0.419 - (x1^2) * (x3^2)/(10^7) >= 0
    ceq = []; % 没有等式约束
end

% 定义变量的初始值
x0 = [1, 1, 1]; % 初始猜测值

% 设置变量范围
lb = [0, 0, 0];  % 下界
ub = [36, 5, 125];  % 上界

% 使用 fmincon 进行优化
options = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'sqp');
[x_opt, fval] = fmincon(@objective, x0, [], [], [], [], lb, ub, @constraints, options);

% 显示结果
fprintf('最优解: x1 = %.4f, x2 = %.4f, x3 = %.4f\n', x_opt(1), x_opt(2), x_opt(3));
fprintf('最大目标函数值: %.4f\n', -fval); % 目标函数值为负，故需取反
