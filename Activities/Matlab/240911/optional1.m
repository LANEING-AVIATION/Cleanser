function count = optional1()
    % 定义数字集合
    digits_set = [1, 2, 3, 4, 5, 6];
    
    % 生成所有可能的5位数组合
    all_combinations = combvec(digits_set, digits_set, digits_set, digits_set, digits_set)';
    
    % 初始化满足条件的密码计数
    count = 0;
    
    % 遍历每个组合
    for i = 1:size(all_combinations, 1)
        password = all_combinations(i, :);
        
        % 检查条件1：至少三个数字互不相同
        if length(unique(password)) < 3
            continue;  % 不满足条件，跳过
        end
        
        % 检查条件2：相邻两个数字之差的绝对值不为3
        valid = true;  % 假设密码有效
        for j = 1:length(password)-1
            if abs(password(j) - password(j+1)) == 3
                valid = false;  % 如果有相邻差为3的，密码无效
                break;
            end
        end
        
        % 如果满足两个条件，计数加1
        if valid
            count = count + 1;
        end
    end
end
