// Problem: Maximize the total prosperity of gangsters entering a restaurant
#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

struct Gangster {
    int time;
    int prosperity;
    int stoutness;
};

int main() {
    int N, K, T;
    cin >> N >> K >> T;
    
    vector<Gangster> gangsters(N);
    for (int i = 0; i < N; ++i) {
        cin >> gangsters[i].time;
    }
    for (int i = 0; i < N; ++i) {
        cin >> gangsters[i].prosperity;
    }
    for (int i = 0; i < N; ++i) {
        cin >> gangsters[i].stoutness;
    }

    // DP table to store the maximum prosperity at each time and door state
    vector<vector<int>> dp(T + 1, vector<int>(K + 1, 0));

    for (int t = 0; t <= T; ++t) {
        for (int k = 0; k <= K; ++k) {
            if (t > 0) {
                dp[t][k] = max(dp[t][k], dp[t - 1][k]); // Stay at the same state
                if (k > 0) dp[t][k] = max(dp[t][k], dp[t - 1][k - 1]); // Open more
                if (k < K) dp[t][k] = max(dp[t][k], dp[t - 1][k + 1]); // Close more
            }
            for (const auto& gangster : gangsters) {
                if (gangster.time == t && gangster.stoutness == k) {
                    dp[t][k] += gangster.prosperity;
                }
            }
        }
    }

    // Find the maximum prosperity at the end of time T
    int max_prosperity = 0;
    for (int k = 0; k <= K; ++k) {
        max_prosperity = max(max_prosperity, dp[T][k]);
    }

    cout << max_prosperity << endl;
    return 0;
}
