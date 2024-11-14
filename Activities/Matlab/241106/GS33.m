% 系数矩阵A 和常数项b
A = [4, -2, -1; -2, 4, -2; -1, -2, 3];
b = [0; -2; 3];

% 设置初始值（可以选择0或其他值）
X = [1, 1, 1];

% 设置迭代次数和误差阈值
max_iter = 1000;  % 最大迭代次数
tol = 1e-5;       % 误差阈值

% Gauss-Seidel 迭代
for k = 1:max_iter
    X_new = X;  % 创建新的解向量
    
    % 计算每个变量的新值，立即使用新的值
    X_new(1) = (b(1) + 2*X_new(2) + X_new(3)) / 4;
    X_new(2) = (b(2) + 2*X_new(1) + 2*X_new(3)) / 4;
    X_new(3) = (b(3) + X_new(1) + 2*X_new(2)) / 3;
    disp(X_new);
    
    % 检查是否满足误差要求
    if norm(X_new - X, inf) < tol
        disp(['收敛，迭代次数：', num2str(k)]);
        break;
    end
    
    % 更新X为新的解向量
    X = X_new;
end

% 输出结果
disp('解向量 X 为：');
disp(X);
