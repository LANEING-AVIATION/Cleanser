#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

// Function to count inversions in a string
int countInversions(const string &s) {
    int inversions = 0;
    for (size_t i = 0; i < s.length(); ++i) {
        for (size_t j = i + 1; j < s.length(); ++j) {
            if (s[i] > s[j]) {
                ++inversions;
            }
        }
    }
    return inversions;
}

int main() {
    int n, m;
    cin >> n >> m;
    vector<pair<string, int>> dna(m);

    // Read DNA strings and calculate their inversion counts
    for (int i = 0; i < m; ++i) {
        cin >> dna[i].first;
        dna[i].second = countInversions(dna[i].first);
    }

    // Sort DNA strings by inversion count, maintaining original order for ties
    stable_sort(dna.begin(), dna.end(), [](const pair<string, int>& a, const pair<string, int>& b) {
        return a.second < b.second;
    });

    // Output sorted DNA strings
    for (const auto &entry : dna) {
        cout << entry.first << endl;
    }

    return 0;
}
