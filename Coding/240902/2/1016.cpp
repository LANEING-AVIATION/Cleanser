#include <iostream>
#include <string>
#include <unordered_map>
#include <vector>
#include <algorithm> // 添加此行以包含sort函数

using namespace std;

// Function to compute the inventory of a number
string computeInventory(const string &num) {
    unordered_map<char, int> count;
    for (char c : num) {
        count[c]++;
    }
    vector<pair<int, char>> inventory;
    for (auto &entry : count) {
        inventory.emplace_back(entry.second, entry.first);
    }
    
    // 修正排序比较函数
    sort(inventory.begin(), inventory.end(), [](const pair<int, char> &a, const pair<int, char> &b) {
        return a.second < b.second;
    });
    
    string result;
    for (auto &entry : inventory) {
        result += to_string(entry.first) + entry.second;
    }
    return result;
}

int main() {
    string num;
    while (cin >> num && num != "-1") {
        vector<string> history;
        bool classified = false;
        for (int i = 0; i < 15; ++i) {
            if (num == computeInventory(num)) {
                if (i == 0) {
                    cout << num << " is self-inventorying\n";
                } else {
                    cout << num << " is self-inventorying after " << i << " steps\n";
                }
                classified = true;
                break;
            }
            if (find(history.begin(), history.end(), num) != history.end()) {
                int loop_start = find(history.begin(), history.end(), num) - history.begin();
                cout << num << " enters an inventory loop of length " << (i - loop_start) << "\n";
                classified = true;
                break;
            }
            history.push_back(num);
            num = computeInventory(num);
        }
        if (!classified) {
            cout << num << " can not be classified after 15 iterations\n";
        }
    }
    return 0;
}
