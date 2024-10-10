function jacobi_iteration_test()
    % 定义线性方程组 Ax = b
    A = [5 -2 3; -3 9 1; 2 -1 -7];  % 系数矩阵
    b = [-1; 2; 3];  % 常数向量

    % 设置初始猜测值，可以更改以验证初值的影响
    x0 = [0; 0; 0];  % 初值1
    % x0 = [1; 1; 1];  % 初值2
    tol = 1e-6;  % 设定收敛容差
    max_iter = 100;  % 设定最大迭代次数

    % 使用Jacobi迭代法求解
    [x, iter] = jacobi(A, b, x0, tol, max_iter);

    % 显示最终解和迭代次数
    disp('最终解:');
    disp(x);
    disp(['总共迭代次数: ', num2str(iter)]);

    % 验证初值影响
    % 可以修改 x0 并重新运行程序，观察不同初值的迭代过程和结果是否一致。
end

function [x, iter] = jacobi(A, b, x0, tol, max_iter)
    % Jacobi 迭代法求解线性方程组 Ax = b
    D = diag(diag(A));  % 提取A的对角线元素
    R = A - D;  % A = D + R，其中R是A的非对角部分

    x = x0;  % 初始解
    iter = 0;  % 迭代计数

    while iter < max_iter
        x_new = D \ (b - R * x);  % Jacobi 迭代公式

        % 检查收敛条件（欧几里得范数）
        if norm(x_new - x, inf) < tol
            break;
        end

        x = x_new;  % 更新解
        iter = iter + 1;  % 增加迭代次数
    end
end
