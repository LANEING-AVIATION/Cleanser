// 将电话号码转换为标准格式并找出重复的号码
#include <iostream>
#include <string>
#include <map>
#include <vector>
#include <algorithm>

using namespace std;

// 将字母映射到对应的数字
char mapCharToDigit(char c) {
    if (c >= 'A' && c <= 'C') return '2';
    if (c >= 'D' && c <= 'F') return '3';
    if (c >= 'G' && c <= 'I') return '4';
    if (c >= 'J' && c <= 'L') return '5';
    if (c >= 'M' && c <= 'O') return '6';
    if (c >= 'P' && c <= 'S') return '7';
    if (c >= 'T' && c <= 'V') return '8';
    if (c >= 'W' && c <= 'Y') return '9';
    return c; // 对于数字和连字符，直接返回
}

// 将电话号码转换为标准格式
string convertToStandardForm(const string& phone) {
    string standardForm;
    for (char c : phone) {
        if (c != '-') {
            standardForm += mapCharToDigit(c);
        }
    }
    // 插入连字符
    standardForm.insert(3, "-");
    return standardForm;
}

int main() {
    int n;
    cin >> n;
    map<string, int> phoneCount;
    vector<string> phones(n);

    // 读取输入并转换为标准格式
    for (int i = 0; i < n; ++i) {
        cin >> phones[i];
        string standardForm = convertToStandardForm(phones[i]);
        phoneCount[standardForm]++;
    }

    // 存储重复的电话号码
    vector<pair<string, int>> duplicates;
    for (const auto& entry : phoneCount) {
        if (entry.second > 1) {
            duplicates.push_back(entry);
        }
    }

    // 按字典顺序排序
    sort(duplicates.begin(), duplicates.end());

    // 输出结果
    if (duplicates.empty()) {
        cout << "No duplicates." << endl;
    } else {
        for (const auto& entry : duplicates) {
            cout << entry.first << " " << entry.second << endl;
        }
    }

    return 0;
}
