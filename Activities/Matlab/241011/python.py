from scipy.optimize import linprog
import numpy as np

# 数据
supply = [20, 30, 25, 35]
demand = [10, 15, 25, 30, 30]
cost = np.array([
    [8, 6, 10, 9, 7],
    [9, 12, 13, 7, 6],
    [14, 9, 16, 5, 8],
    [12, 8, 7, 6, 9]
])

# 优化问题的变量和约束
c = cost.flatten()
A_eq = np.vstack([np.kron(np.eye(4), np.ones(5)), np.kron(np.ones(4), np.eye(5))])
b_eq = np.hstack([supply, demand])

# 求解
res = linprog(c, A_eq=A_eq, b_eq=b_eq, bounds=(0, None), method='highs')

# 结果
X = res.x.reshape(cost.shape)
print('最优运输计划：')
print(X)
print(f'总运费：{res.fun}')
