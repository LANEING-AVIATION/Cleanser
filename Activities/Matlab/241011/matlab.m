% 数据
supply = [20, 30, 25, 35];
demand = [10, 15, 25, 30, 30];
cost = [8, 6, 10, 9, 7;
        9, 12, 13, 7, 6;
        14, 9, 16, 5, 8;
        12, 8, 7, 6, 9];

% 优化问题的变量和约束
c = cost';  % 按列优先展平成本矩阵
c = c(:);   % 转为列向量
A_eq = [kron(eye(4), ones(1, 5)); kron(ones(1, 4), eye(5))];  % 约束矩阵
b_eq = [supply, demand]';  % 约束向量

% 增加选项设置，使用dual-simplex算法
options = optimoptions('linprog', 'Algorithm', 'dual-simplex', 'Display', 'iter');

% 求解
[x, fval, exitflag, output] = linprog(c, [], [], A_eq, b_eq, zeros(size(c)), [], options);

% 检查求解状态
if exitflag == 1
        % 结果处理
        X = reshape(x, size(cost));  % 恢复矩阵形式
        disp('最优运输计划：');
        disp(X);
        fprintf('总运费：%.2f\n', fval);
    else
        % 处理无法求解的情况
        disp('无法找到最优解，检查约束条件或数据输入。');
        disp(output.message);
end
