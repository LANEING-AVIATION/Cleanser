% 初始化数字集合
numbers = 1:6;


% 用于存储满足条件的密码组合数量
valid_passwords_count = 0;

% 递归函数生成密码
function generate_password(current_password, depth, numbers)
    global valid_passwords_count;
    
    % 当密码长度为 5 时，检查其是否符合要求
    if depth == 5
        if check_unique_digits(current_password) && check_difference(current_password)
            valid_passwords_count = valid_passwords_count + 1;
        end
        return;
    end
    
    % 枚举每个数字，并递归生成密码
    for i = 1:length(numbers)
        generate_password([current_password, numbers(i)], depth + 1, numbers);
    end
end

% 检查密码是否至少包含 3 个不同的数字
function result = check_unique_digits(password)
    if length(unique(password)) >= 3
        result = true;
    else
        result = false;
    end
end

% 检查相邻两个数字之差的绝对值是否为 3
function result = check_difference(password)
    result = true;
    for i = 1:length(password)-1
        if abs(password(i) - password(i+1)) == 3
            result = false;
            break;
        end
    end
end

% 开始生成密码
generate_password([], 0, numbers);

% 输出结果
fprintf('符合条件的密码锁数量: %d\n', valid_passwords_count);
