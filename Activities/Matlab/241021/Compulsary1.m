% 学生数量
students = [34, 29, 42, 21, 56, 18, 71]; % A, B, C, D, E, F, G
num_zones = length(students);

% 定义代理点相邻的区域
adjacency = [1 2; 1 3; 2 3; 2 4; 2 5; 3 4; 4 5; 4 6; 4 7; 5 6; 6 7]; % [A, B], [A, C], ...

% 线性规划设置
f = -students; % 目标函数系数（取负因为是最大化）
intcon = 1:num_zones; % 整数变量
Aeq = ones(1, num_zones); % 代理点总数约束
beq = 2; % 只能选择两个代理点
A = []; b = [];

% 添加不相邻约束
for i = 1:size(adjacency, 1)
    row = zeros(1, num_zones);
    row(adjacency(i, :)) = 1;
    A = [A; row];
    b = [b; 1];
end

% 求解整数线性规划
options = optimoptions('intlinprog', 'Display', 'off');
[x, fval] = intlinprog(f, intcon, A, b, Aeq, beq, zeros(num_zones, 1), ones(num_zones, 1));

% 结果输出
disp('选定的代理点为：');
for i = 1:num_zones
    if x(i) > 0
        fprintf('%c ', 'A'+(i-1)); % 输出代理点
    end
end
fprintf('\n');