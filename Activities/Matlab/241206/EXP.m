% 定义矩阵A和右侧常数列b
A = [2 4 2 6; 4 9 6 15; 2 6 9 18; 6 15 18 40];
b = [9; 23; 22; 47];

% 初始化L和U矩阵
n = length(b);
L = zeros(n, n);
U = zeros(n, n);

% LU分解 (Crout法)
for k = 1:n
    % 计算L的第k列
    L(k, k) = A(k, k) - sum(L(k, 1:k-1) .* U(1:k-1, k)');
    
    for i = k+1:n
        L(i, k) = A(i, k) - sum(L(i, 1:k-1) .* U(1:k-1, k)');
    end
    
    % 计算U的第k行
    for j = k+1:n
        U(k, j) = (A(k, j) - sum(L(k, 1:k-1) .* U(1:k-1, j)')) / L(k, k);
    end
end

% 将U矩阵的对角线元素设为1
for k = 1:n
    U(k, k) = 1;
end

% 输出L和U矩阵
disp('L矩阵:');
disp(L);
disp('U矩阵:');
disp(U);

% 进行前向替代求解y
y = zeros(n, 1);
y(1) = b(1) / L(1, 1);  % 初始条件

for k = 2:n
    y(k) = (b(k) - sum(L(k, 1:k-1) .* y(1:k-1))) / L(k, k);  % 使用前面已知的y值
end

% 输出y的结果
disp('y向量:');
disp(y);

% 进行后向替代求解x
x = zeros(n, 1);
x(n) = y(n);  % 初始条件

for k = n-1:-1:1
    x(k) = y(k) - sum(U(k, k+1:n) .* x(k+1:n));  % 使用后面已知的x值
end

% 输出x的结果
disp('解x:');
disp(x);
