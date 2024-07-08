#include <iostream>
#include <cstdlib> // for rand() and srand()
#include <ctime>   // for time()

int main() {
    // 初始化随机数生成器
    std::srand(std::time(0));

    // 生成1到100之间的随机数
    int secretNumber = std::rand() % 100 + 1;
    int guess = 0;
    int attempts = 0;

    std::cout << "欢迎来到猜数字游戏！\n";
    std::cout << "我已经选好了一个1到100之间的数字。你能猜出来吗？\n";

    // 游戏循环
    while (guess != secretNumber) {
        std::cout << "请输入你的猜测：";
        std::cin >> guess;
        attempts++;

        if (guess < secretNumber) {
            std::cout << "太低了！再试一次。\n";
        } else if (guess > secretNumber) {
            std::cout << "太高了！再试一次。\n";
        } else {
            std::cout << "恭喜你！你猜对了！\n";
            std::cout << "你一共猜了 " << attempts << " 次。\n";
        }
    }

    return 0;
}
