% 数据
supply = [20, 30, 25, 35];
demand = [10, 15, 25, 30, 30];
cost = [8, 6, 10, 9, 7;
        9, 12, 13, 7, 6;
        14, 9, 16, 5, 8;
        12, 8, 7, 6, 9];

% 优化问题的变量和约束
c = cost(:);  % 将cost矩阵展开为列向量
A_eq = [kron(eye(4), ones(1, 5)); kron(ones(1, 4), eye(5))];
b_eq = [supply, demand]';

% 整数变量索引
num_vars = length(c);
intcon = 1:num_vars;  % 所有变量必须为整数

% 使用 intlinprog 方法求解整数线性规划
[x, fval] = intlinprog(c, intcon, [], [], A_eq, b_eq, zeros(size(c)), []);

% 结果
X = reshape(x, size(cost));
disp('最优运输计划：');
disp(X);
fprintf('总运费：%.2f\n', fval);