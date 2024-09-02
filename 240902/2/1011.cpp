/*
 * Problem: Restore original sticks from parts.
 * Constraints: Use the smallest possible original length.
 */

#include <iostream>
#include <vector>
#include <algorithm>
#include <numeric>

using namespace std;

// Function to check if we can form sticks of length 'target' using parts
bool canFormSticks(vector<int>& parts, vector<bool>& used, int target, int currentLength, int index, int stickCount) {
    if (stickCount == 0) return true;
    if (currentLength == target) return canFormSticks(parts, used, target, 0, 0, stickCount - 1);

    for (int i = index; i < parts.size(); ++i) {
        if (!used[i] && currentLength + parts[i] <= target) {
            used[i] = true;
            if (canFormSticks(parts, used, target, currentLength + parts[i], i + 1, stickCount)) return true;
            used[i] = false;
            if (currentLength == 0 || currentLength + parts[i] == target) return false;
            while (i + 1 < parts.size() && parts[i] == parts[i + 1]) ++i;
        }
    }
    return false;
}

int main() {
    int n;
    while (cin >> n && n != 0) {
        vector<int> parts(n);
        int sum = 0;
        for (int i = 0; i < n; ++i) {
            cin >> parts[i];
            sum += parts[i];
        }
        sort(parts.rbegin(), parts.rend());

        for (int length = parts[0]; length <= sum; ++length) {
            if (sum % length == 0) {
                vector<bool> used(n, false);
                if (canFormSticks(parts, used, length, 0, 0, sum / length)) {
                    cout << length << endl;
                    break;
                }
            }
        }
    }
    return 0;
}
