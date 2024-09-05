/*
 * Problem: Allocate stamps to customers based on their needs and available denominations.
 * Constraints: Maximize different types of stamps, minimize duplicates, and use at most 4 stamps.
 */

#include <iostream>
#include <vector>
#include <algorithm>
#include <set>

using namespace std;

// Function to find the best combination of stamps
void findBestCombination(const vector<int>& stamps, const vector<int>& requests) {
    for (int request : requests) {
        vector<vector<int>> combinations;
        int bestTypeCount = 0, minStampCount = 5, maxSingleValue = 0;
        vector<int> bestCombination;

        // Generate all combinations of up to 4 stamps
        for (int i = 0; i < stamps.size(); ++i) {
            for (int j = i; j < stamps.size(); ++j) {
                for (int k = j; k < stamps.size(); ++k) {
                    for (int l = k; l < stamps.size(); ++l) {
                        int sum = stamps[i] + stamps[j] + stamps[k] + stamps[l];
                        if (sum == request) {
                            vector<int> combination = {stamps[i], stamps[j], stamps[k], stamps[l]};
                            set<int> uniqueStamps(combination.begin(), combination.end());
                            int typeCount = uniqueStamps.size();
                            int stampCount = combination.size();
                            int singleValue = *max_element(combination.begin(), combination.end());

                            // Check if this combination is better
                            if (typeCount > bestTypeCount ||
                                (typeCount == bestTypeCount && stampCount < minStampCount) ||
                                (typeCount == bestTypeCount && stampCount == minStampCount && singleValue > maxSingleValue)) {
                                bestTypeCount = typeCount;
                                minStampCount = stampCount;
                                maxSingleValue = singleValue;
                                bestCombination = combination;
                            }
                        }
                    }
                }
            }
        }

        // Output the result for this request
        if (bestCombination.empty()) {
            cout << request << " ---- none" << endl;
        } else {
            cout << request << " (" << bestTypeCount << "):";
            for (int stamp : bestCombination) {
                cout << " " << stamp;
            }
            cout << endl;
        }
    }
}

int main() {
    vector<int> stamps;
    vector<int> requests;
    int value;

    // Read input
    while (cin >> value) {
        if (value == 0) {
            if (!stamps.empty() && !requests.empty()) {
                findBestCombination(stamps, requests);
                stamps.clear();
                requests.clear();
            }
        } else {
            if (stamps.empty() || requests.empty()) {
                stamps.push_back(value);
            } else {
                requests.push_back(value);
            }
        }
    }

    return 0;
}
