function max_trees = plant_trees()
    land_size = 500; % 土地边长500米
    tree_area = 10; % 每棵树占地10平方米
    safe_distance = 5; % 树干之间的安全距离
    max_height = 25; % 最大树高

    % 冠幅与高度的关系
    heights = [5, 10, 15, 20, 25];
    canopies = [2.8, 5.5, 8.5, 11.9, 14.5];

    % 计算可种植的最大树木数
    max_trees_possible = land_size^2 / tree_area;

    % 进行树的种植
    positions = []; % 记录树的位置
    heights_selected = []; % 记录树的高度

    for i = 1:max_trees_possible
        % 随机生成树的位置
        x = rand * land_size;
        y = rand * land_size;
        h = heights(randi(length(heights))); % 随机选择树高

        % 检查是否符合所有条件
        if is_valid_position(x, y, h, positions, canopies, heights)
            positions = [positions; x, y]; % 添加树的位置
            heights_selected = [heights_selected; h]; % 记录树的高度
        end
    end

    max_trees = size(positions, 1); % 最终树木数量
    fprintf('最多可种植树木数量: %d\n', max_trees);
end

function valid = is_valid_position(x, y, h, positions, canopies, heights)
    radius = canopies(find(heights == h)); % 树冠半径
    valid = true;

    % 检查树是否在边界内
    if (x - radius < 0 || x + radius > 500 || y - radius < 0 || y + radius > 500)
        valid = false;
        return;
    end

    % 检查与已有树的安全距离
    for i = 1:size(positions, 1)
        if sqrt((x - positions(i, 1))^2 + (y - positions(i, 2))^2) < 5
            valid = false;
            return;
        end
    end
end
