% 清空环境
clear;
clc;
% 原始数据矩阵
A = [
    80, 90, 85;
    70, 60, 78;
    90, 80, 88;
    85, 75, 92
];
% 指标类型，1表示效益型，0表示成本型
indicator_type = [1, 0, 1];
% 数据标准化处理（效益型: 归一化，成本型: 反归一化）
[n, m] = size(A);
R = zeros(n, m);
for j = 1:m
    if indicator_type(j) == 1
        % 效益型指标归一化
        R(:, j) = (A(:, j) - min(A(:, j))) / (max(A(:, j)) - min(A(:, j)));
    else
        % 成本型指标反归一化
        R(:, j) = (max(A(:, j)) - A(:, j)) / (max(A(:, j)) - min(A(:, j)));
    end
end
% 计算各指标的熵值
k = 1 / log(n);  % 常数k
E = zeros(1, m);
for j = 1:m
    p = R(:, j) ./ sum(R(:, j));
    E(j) = -k * sum(p .* log(p + eps));  % 加eps防止log(0)
end
% 计算各指标的差异系数
d = 1 - E;
% 计算各指标的权重
w = d / sum(d);
% 计算综合得分
Z = R * w';
% 输出综合得分及排序
[sorted_Z, index] = sort(Z, 'descend');
% 输出结果
fprintf('各方案的综合得分：\n');
disp(Z);
fprintf('排序：\n');
disp(index);
% 输出每个方案的综合得分及其对应的排序
for i = 1:n
    fprintf('方案%d = %.4f, 排名 = %d\n', i, Z(i), find(index == i));
end
