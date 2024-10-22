% 读取Excel文件中的数据
data = readtable('1.xls');

% 提取物品编号和数量
items = table2array(data(1, 3:end));  % 提取物品编号（C列及后续）
quantities = table2array(data(2, 3:end));  % 提取物品数量（C列及后续）

% 提取债权人的偏好表
preferences = table2array(data(3:end, 3:end));  % 提取偏好值表
[num_creditors, num_items] = size(preferences);  % 获取债权人数量和物品数量

% 初始化分配矩阵，行对应债权人，列对应物品
allocation = zeros(num_creditors, num_items);

% 贪心算法分配物品
for creditor = 1:num_creditors
    % 对当前债权人的偏好值进行排序，偏好值从高到低
    [~, preference_order] = sort(preferences(creditor, :), 'descend');
    
    % 根据偏好顺序分配物品
    for i = 1:num_items
        item_idx = preference_order(i);  % 债权人对该物品的偏好最高的物品索引
        if quantities(item_idx) > 0
            allocation(creditor, item_idx) = 1;  % 分配物品
            quantities(item_idx) = quantities(item_idx) - 1;  % 减少该物品的剩余量
        end
    end
end

% 输出分配结果
disp('物品分配结果：');
disp(allocation);

% 输出到 Excel 文件
filename = 'outputData.xlsx'; % 你希望保存的文件名
writematrix(allocation, filename); % 使用 writematrix 函数

