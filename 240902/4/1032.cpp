/*
 * Problem: Determine the sizes of groups of delegates in Parliament to maximize the number of days the Parliament can work.
 * Input: A single integer N (5 <= N <= 1000) representing the number of delegates.
 * Output: Sizes of groups that allow the Parliament to work for the maximal possible time.
 */

#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

// Function to find the optimal group sizes
vector<int> findGroupSizes(int N) {
    vector<int> groupSizes;
    int sum = 0;
    for (int i = 1; sum + i <= N; ++i) {
        groupSizes.push_back(i);
        sum += i;
    }
    if (sum < N) {
        groupSizes.back() += N - sum;
    }
    return groupSizes;
}

int main() {
    int N;
    cin >> N;

    vector<int> groupSizes = findGroupSizes(N);

    sort(groupSizes.begin(), groupSizes.end());

    for (int size : groupSizes) {
        cout << size << " ";
    }
    cout << endl;

    return 0;
}
