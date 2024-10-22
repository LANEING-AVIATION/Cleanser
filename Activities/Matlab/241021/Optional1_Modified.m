% 读取Excel文件中的数据
data = readtable('1.xls');

% 提取物品编号和数量
items = table2array(data(1, 3:end));  % 提取物品编号（C列及后续）
quantities = table2array(data(2, 3:end));  % 提取物品数量（C列及后续）

% 提取债权人的偏好表和名字
preferences = table2array(data(3:end, 3:end));  % 提取偏好值表
creditor_names = table2array(data(3:end, 2));  % 提取债权人名字
[num_creditors, num_items] = size(preferences);  % 获取债权人数量和物品数量

% 初始化分配矩阵，行对应债权人，列对应物品
allocation = zeros(num_creditors, num_items);

% 为每个物品进行分配
for idx = 1:num_items
    total_preference = sum(preferences(:, idx));  % 计算该物品的总偏好值
    if total_preference > 0  % 如果有偏好值
        % 计算每个债权人分配的数量
        for creditor = 1:num_creditors
            allocation(creditor, idx) = floor(quantities(idx) * (preferences(creditor, idx) / total_preference));
        end
        
        % 确保分配总数不超过该物品的数量
        while sum(allocation(:, idx)) > quantities(idx)
            % 按偏好降序调整
            [~, sorted_indices] = sort(preferences(:, idx), 'descend');
            for k = sorted_indices'
                if allocation(k, idx) > 0
                    allocation(k, idx) = allocation(k, idx) - 1;
                    if sum(allocation(:, idx)) <= quantities(idx)
                        break;
                    end
                end
            end
        end
    end
end

% 定义一个宽100，高1000的矩阵，所有数据都为0
matrix = zeros(1000, 100);

% 输出物品分配结果到命令行
disp('物品分配结果：');
for creditor = 1:num_creditors
    creditor_name = creditor_names(creditor);  % 债权人名字
    
    % 找到分配的物品编号和数量
    allocated_items = find(allocation(creditor, :));
    item_ids = items(allocated_items);
    item_counts = allocation(creditor, allocated_items);  % 每种物品的分配数量
    
    % 输出结果
    for i = 1:length(item_ids)
        disp([creditor_name, num2str(item_ids(i)), num2str(item_counts(i))]);
        matrix(creditor, item_ids(i)) = item_counts(i);
    end
end

% 将矩阵写入Excel文件
writematrix(matrix, 'outputData.xlsx');

