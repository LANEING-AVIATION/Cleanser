#include <iostream>
#include <vector>
using namespace std;

vector<double> dp;

double expectedSteps(int n) {
    if (n == 1) return 0;
    if (dp[n] != -1) return dp[n];
    
    if (n % 2 == 0) {
        dp[n] = 1 + expectedSteps(n / 2);
    } else {
        dp[n] = 1 + expectedSteps(n - 1);
    }
    
    return dp[n];
}

int main() {
    int n;
    cin >> n;
    dp.resize(n + 1, -1);
    cout << expectedSteps(n) << endl;
    return 0;
}
