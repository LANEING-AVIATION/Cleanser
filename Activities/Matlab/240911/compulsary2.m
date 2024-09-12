% 题目: 找出两个自然数相乘可以得到111、1111、11111，
% 因数不能为1 

numbers = [111, 1111, 11111];

% 循环遍历每个目标数字
for i = 1:length(numbers)
    num = numbers(i);
    fprintf('寻找自然数因数乘积为 %d 的组合:\n', num);
    
    % 遍历可能的因数
    for factor1 = 2:floor(sqrt(num)) % 因数范围限制为从2到sqrt(num)
        if mod(num, factor1) == 0 % 检查是否为因数
            factor2 = num / factor1;
            if factor2 ~= 1 % 排除因数为1的情况
                fprintf('%d = %d * %d\n', num, factor1, factor2);
            end
        end
    end
    fprintf('\n');
end
