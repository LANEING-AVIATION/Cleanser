def calculate_best_option(principal, years, rates):
    # 初始化动态规划数组，存储每年结束时的最大收益和存款策略
    dp = [0] * (years + 1)
    strategy = [None] * (years + 1)
    
    # 遍历每一年的存款选择
    for year in range(1, years + 1):
        for term, rate in rates.items():
            if year >= term:
                # 计算当前的收益
                future_value = principal * (1 + rate / 100)
                if future_value > dp[year]:
                    dp[year] = future_value
                    # 记录存款策略
                    strategy[year] = (term, future_value)

    return dp, strategy

def get_saving_plan(principal, years, rates):
    # 计算最佳选项
    dp, strategy = calculate_best_option(principal, years, rates)

    # 输出最佳收益和存款步骤
    total_profit = dp[years]
    plan = []
    current_year = years

    while current_year > 0:
        term, future_value = strategy[current_year]
        plan.append((current_year - term + 1, term))
        current_year -= term

    plan.reverse()  # 反转计划顺序，以便从开始到结束展示

    return total_profit, plan

# 利率设置
rates = {
    1: 1.35,
    2: 1.45,
    3: 1.75,
    5: 1.80
}

# 本金和投资年份
principal = 1  # 初始本金设为1，用于计算总收益
years = 33

# 计算最佳存款方案
total_profit, saving_plan = get_saving_plan(principal, years, rates)

# 输出结果
print(f"总收益（本金1元，33年后）: {total_profit:.2f}元")
print("存款策略（起始年, 存款年限）:")
for start_year, term in saving_plan:
    print(f"从第 {start_year} 年存款 {term} 年")