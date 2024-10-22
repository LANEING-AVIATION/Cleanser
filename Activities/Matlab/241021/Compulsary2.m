% 初始资金
initial_fund = 100000;

% 项目A
investment_A = [10000, 10000, 10000, 10000];
return_A = [11500, 11500, 11500, 11500];

% 项目B
investment_B = [0, 0, 40000, 0, 0];
return_B = [0, 0, 0, 0, 50000];

% 项目C
investment_C = [0, 30000, 0, 0, 0];
return_C = [0, 0, 0, 0, 42000];

% 项目D
investment_D = [0, 0, 0, 0, 0];
return_D = [0, 0, 0, 0, 0.06];

% 初始化资金数组
fund = zeros(6, 1); % 确保数组有6个元素，以避免索引超出范围
fund(1) = initial_fund;

% 每年进行投资并计算回报
for year = 1:5
    if year <= 4
        % 投资项目A
        fund(year) = fund(year) - investment_A(year);
        fund(year + 1) = fund(year + 1) + return_A(year);
    end

    if year >= 3
        % 投资项目B
        fund(year) = fund(year) - investment_B(year);
        if year < 5
            fund(year + 1) = fund(year + 1) + return_B(year);
        end
    end

    if year == 2
        % 投资项目C
        fund(year) = fund(year) - investment_C(year);
        fund(year + 3) = fund(year + 3) + return_C(year);
    end

    % 投资项目D
    fund(year) = fund(year) - investment_D(year);
    if year < 5
        fund(year + 1) = fund(year + 1) + (investment_D(year) * return_D(year));
    end
end

% 输出最终资金
final_fund = fund(5);
disp(['第五年末拥有的资金总额为：', num2str(final_fund)]);
