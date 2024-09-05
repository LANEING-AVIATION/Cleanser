// Problem: Find the C-th cute wooden fence with N planks
#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

vector<vector<long long>> dp(21, vector<long long>(21, 0));
vector<int> result;

void precompute() {
    for (int i = 1; i <= 20; ++i) {
        dp[i][0] = dp[i][i] = 1;
        for (int j = 1; j < i; ++j) {
            dp[i][j] = dp[i-1][j-1] + dp[i-1][j];
        }
    }
}

void findFence(int N, long long C, vector<int>& fence, vector<bool>& used) {
    if (N == 0) return;
    for (int i = 1; i <= 20; ++i) {
        if (used[i]) continue;
        int left = fence.size() % 2 == 0 ? i : -i;
        int right = fence.size() % 2 == 0 ? -i : i;
        long long count = dp[N-1][(N-1)/2];
        if (C <= count) {
            fence.push_back(i);
            used[i] = true;
            findFence(N-1, C, fence, used);
            return;
        }
        C -= count;
    }
}

int main() {
    precompute();
    int K;
    cin >> K;
    while (K--) {
        int N;
        long long C;
        cin >> N >> C;
        vector<int> fence;
        vector<bool> used(21, false);
        findFence(N, C, fence, used);
        for (int i = 0; i < fence.size(); ++i) {
            cout << fence[i] << (i == fence.size() - 1 ? '\n' : ' ');
        }
    }
    return 0;
}
