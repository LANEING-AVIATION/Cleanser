/*
 * Problem: Determine the minimal m such that all bad guys are executed before the first good guy.
 * Constraints: 0 < k < 14
 */

#include <iostream>
#include <vector>

using namespace std;

// Function to simulate the Josephus problem
int josephus(int n, int k) {
    int pos = 0;
    for (int i = 1; i <= n; ++i) {
        pos = (pos + k) % i;
    }
    return pos;
}

// Function to find the minimal m for given k
int findMinimalM(int k) {
    int m = 1;
    while (true) {
        bool allBadExecuted = true;
        for (int i = 0; i < k; ++i) {
            if (josephus(2 * k, m) < k) {
                allBadExecuted = false;
                break;
            }
        }
        if (allBadExecuted) {
            return m;
        }
        ++m;
    }
}

int main() {
    int k;
    while (cin >> k && k != 0) {
        cout << findMinimalM(k) << endl;
    }
    return 0;
}
