/*
 * Problem: Divide a collection of marbles into two equal-value sets.
 * Constraints: Each marble has a value between 1 and 6. Max total marbles = 20000.
 */

#include <iostream>
#include <vector>
#include <cstring>

using namespace std;

// Function to check if the marbles can be divided into two equal-value sets
bool canBeDivided(const vector<int>& marbles) {
    int totalValue = 0;
    for (int i = 0; i < 6; ++i) {
        totalValue += marbles[i] * (i + 1);
    }

    if (totalValue % 2 != 0) return false;

    int target = totalValue / 2;
    vector<bool> dp(target + 1, false);
    dp[0] = true;

    for (int i = 0; i < 6; ++i) {
        for (int j = 0; j < marbles[i]; ++j) {
            for (int k = target; k >= (i + 1); --k) {
                if (dp[k - (i + 1)]) {
                    dp[k] = true;
                }
            }
        }
    }

    return dp[target];
}

int main() {
    int caseNumber = 1;
    while (true) {
        vector<int> marbles(6);
        bool isEmpty = true;
        for (int i = 0; i < 6; ++i) {
            cin >> marbles[i];
            if (marbles[i] != 0) isEmpty = false;
        }
        if (isEmpty) break;

        cout << "Collection #" << caseNumber++ << ":\n";
        if (canBeDivided(marbles)) {
            cout << "Can be divided.\n";
        } else {
            cout << "Can't be divided.\n";
        }
        cout << endl;
    }

    return 0;
}
