// POJ 1019: Number Sequence
// Find the digit located at position i in the sequence of number groups S1S2...Sk

#include <iostream>
#include <cmath>

using namespace std;

const int MAX_GROUP = 31269; // Maximum number of groups needed
unsigned long long groupLength[MAX_GROUP]; // Length of each group
unsigned long long totalLength[MAX_GROUP]; // Cumulative length up to each group

void precomputeLengths() {
    groupLength[1] = 1;
    totalLength[1] = 1;
    for (int i = 2; i < MAX_GROUP; ++i) {
        groupLength[i] = groupLength[i - 1] + (int)log10(i) + 1;
        totalLength[i] = totalLength[i - 1] + groupLength[i];
    }
}

int findDigit(int n) {
    int group = 1;
    while (totalLength[group] < n) {
        ++group;
    }
    int posInGroup = n - totalLength[group - 1];
    int number = 1;
    while (posInGroup > (int)log10(number) + 1) {
        posInGroup -= (int)log10(number) + 1;
        ++number;
    }
    string numberStr = to_string(number);
    return numberStr[posInGroup - 1] - '0';
}

int main() {
    precomputeLengths();
    int t;
    cin >> t;
    while (t--) {
        int i;
        cin >> i;
        cout << findDigit(i) << endl;
    }
    return 0;
}
