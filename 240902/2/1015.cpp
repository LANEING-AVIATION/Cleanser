// POJ 1015: Jury Compromise
// Select m jurors from n candidates to minimize |D(J) - P(J)| and maximize D(J) + P(J)

#include <iostream>
#include <vector>
#include <algorithm>
#include <cstring>

using namespace std;

struct Candidate {
    int p, d; // Prosecution and Defence values
};

int n, m;
vector<Candidate> candidates;
int dp[21][401][401]; // DP table
int path[21][401][401]; // Path table to track selected candidates

void printPath(int i, int j, int k) {
    if (i == 0) return;
    printPath(i - 1, j - candidates[path[i][j][k]].p + 200, k - candidates[path[i][j][k]].d + 200);
    cout << " " << path[i][j][k] + 1;
}

int main() {
    int round = 0;
    while (cin >> n >> m && n && m) {
        candidates.resize(n);
        for (int i = 0; i < n; ++i) {
            cin >> candidates[i].p >> candidates[i].d;
        }

        memset(dp, -1, sizeof(dp));
        dp[0][200][200] = 0;

        for (int i = 0; i < n; ++i) {
            for (int j = m - 1; j >= 0; --j) {
                for (int k = 0; k <= 400; ++k) {
                    for (int l = 0; l <= 400; ++l) {
                        if (dp[j][k][l] != -1) {
                            int np = k + candidates[i].p;
                            int nd = l + candidates[i].d;
                            if (dp[j + 1][np][nd] < dp[j][k][l] + candidates[i].p + candidates[i].d) {
                                dp[j + 1][np][nd] = dp[j][k][l] + candidates[i].p + candidates[i].d;
                                path[j + 1][np][nd] = i;
                            }
                        }
                    }
                }
            }
        }

        int bestP = 0, bestD = 0, bestSum = -1;
        for (int i = 0; i <= 400; ++i) {
            for (int j = 0; j <= 400; ++j) {
                if (dp[m][i][j] != -1) {
                    int diff = abs(i - j);
                    int sum = dp[m][i][j];
                    if (bestSum == -1 || diff < abs(bestP - bestD) || (diff == abs(bestP - bestD) && sum > bestSum)) {
                        bestP = i;
                        bestD = j;
                        bestSum = sum;
                    }
                }
            }
        }

        cout << "Jury #" << ++round << "\n";
        cout << "Best jury has value " << bestP - 200 << " for prosecution and value " << bestD - 200 << " for defence:\n";
        printPath(m, bestP, bestD);
        cout << "\n\n";
    }
    return 0;
}
