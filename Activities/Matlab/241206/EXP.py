import numpy as np

# 定义矩阵A和右侧常数列b
A = np.array([[2, 4, 2, 6],
              [4, 9, 6, 15],
              [2, 6, 9, 18],
              [6, 15, 18, 40]])
b = np.array([9, 23, 22, 47])

# 初始化L和U矩阵
n = len(b)
L = np.zeros((n, n))
U = np.zeros((n, n))

# LU分解 (Crout法)
for k in range(n):
    # 计算L的第k列
    L[k, k] = A[k, k] - np.sum(L[k, :k] * U[:k, k])

    for i in range(k + 1, n):
        L[i, k] = A[i, k] - np.sum(L[i, :k] * U[:k, k])

    # 计算U的第k行
    for j in range(k + 1, n):
        U[k, j] = (A[k, j] - np.sum(L[k, :k] * U[:k, j])) / L[k, k]

# 将U矩阵的对角线元素设为1
for k in range(n):
    U[k, k] = 1

# 输出L和U矩阵
print("L矩阵:")
print(L)
print("U矩阵:")
print(U)

# 进行前向替代求解y
y = np.zeros(n)
y[0] = b[0] / L[0, 0]  # 初始条件

for k in range(1, n):
    y[k] = (b[k] - np.sum(L[k, :k] * y[:k])) / L[k, k]

# 输出y的结果
print("\ny向量:")
print(y)

# 进行后向替代求解x
x = np.zeros(n)
x[-1] = y[-1]  # 初始条件

for k in range(n - 2, -1, -1):
    x[k] = y[k] - np.sum(U[k, k+1:] * x[k+1:])

# 输出x的结果
print("\n解x:")
print(x)
