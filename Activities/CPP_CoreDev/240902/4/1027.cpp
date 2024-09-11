#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

int main() {
    int n;
    cin >> n; // 读取序列长度
    vector<int> sequence(n); // 序列
    for (int i = 0; i < n; ++i) {
        cin >> sequence[i];
    }

    vector<int> dp(n, 1); // DP数组，初始化为1

    for (int i = 1; i < n; ++i) {
        for (int j = 0; j < i; ++j) {
            if (sequence[i] > sequence[j]) {
                dp[i] = max(dp[i], dp[j] + 1);
            }
        }
    }

    int lis_length = *max_element(dp.begin(), dp.end()); // 找到最大值，即最长上升子序列的长度
    cout << lis_length << endl;

    return 0;
}
