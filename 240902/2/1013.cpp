/*
 * Problem: Identify the counterfeit coin among 12 coins using exactly three weighings.
 * Constraints: The counterfeit coin is either heavier or lighter.
 */

#include <iostream>
#include <vector>
#include <string>

using namespace std;

// Function to determine the counterfeit coin
void findCounterfeitCoin(int n, vector<vector<string>>& weighings) {
    for (int i = 0; i < n; ++i) {
        vector<string> left(3), right(3), result(3);
        for (int j = 0; j < 3; ++j) {
            left[j] = weighings[i][j * 3];
            right[j] = weighings[i][j * 3 + 1];
            result[j] = weighings[i][j * 3 + 2];
        }

        for (char coin = 'A'; coin <= 'L'; ++coin) {
            for (int weight = -1; weight <= 1; weight += 2) {
                bool possible = true;
                for (int j = 0; j < 3; ++j) {
                    int leftWeight = 0, rightWeight = 0;
                    for (char c : left[j]) leftWeight += (c == coin ? weight : 1);
                    for (char c : right[j]) rightWeight += (c == coin ? weight : 1);

                    if ((result[j] == "even" && leftWeight != rightWeight) ||
                        (result[j] == "up" && leftWeight <= rightWeight) ||
                        (result[j] == "down" && leftWeight >= rightWeight)) {
                        possible = false;
                        break;
                    }
                }
                if (possible) {
                    cout << coin << " is the counterfeit coin and it is " << (weight == 1 ? "heavy." : "light.") << endl;
                    break;
                }
            }
        }
    }
}

int main() {
    int n;
    cin >> n;
    vector<vector<string>> weighings(n, vector<string>(9));
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < 9; ++j) {
            cin >> weighings[i][j];
        }
    }

    findCounterfeitCoin(n, weighings);
    return 0;
}
