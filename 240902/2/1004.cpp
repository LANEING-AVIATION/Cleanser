// 计算 Larry 过去十二个月的平均账户余额

#include <iostream>
#include <iomanip>

int main() {
    double balance, total = 0.0;

    // 读取12个月的账户余额并计算总和
    for (int i = 0; i < 12; ++i) {
        std::cin >> balance;
        total += balance;
    }

    // 计算平均值并输出，保留两位小数
    double average = total / 12;
    std::cout << std::fixed << std::setprecision(2) << "$" << average << std::endl;

    return 0;
}
