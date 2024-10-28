function x = gaussEliminationPivot(A, b)
    n = length(b);
    Aug = [A b]; % 形成增广矩阵 [A|b]
    
    % 前向消元并进行列主元选择
    for i = 1:n-1
        % 找到列主元（绝对值最大）并交换行
        [~, maxIndex] = max(abs(Aug(i:n, i)));
        maxIndex = maxIndex + i - 1;
        if maxIndex ~= i
            Aug([i maxIndex], :) = Aug([maxIndex i], :);
        end
        
        % 消元
        for j = i+1:n
            factor = Aug(j, i) / Aug(i, i);
            Aug(j, :) = Aug(j, :) - factor * Aug(i, :);
        end
    end
    
    % 回代过程
    x = zeros(n, 1);
    x(n) = Aug(n, end) / Aug(n, n);
    for i = n-1:-1:1
        x(i) = (Aug(i, end) - Aug(i, i+1:n) * x(i+1:n)) / Aug(i, i);
    end
end

% 定义矩阵 A 和向量 b
A = [0.5, 1.1, 3.1;
     2.0, 4.5, 0.36;
     5.0, 0.96, 6.5];
b = [6.0; 0.02; 0.96];

% 调用函数
x = gaussEliminationPivot(A, b);
disp('列主元 Gauss 消去法的解为:');
disp(x);
