// Problem: Determine if two 2D-Nim board states are equivalent
#include <iostream>
#include <vector>
#include <set>
#include <algorithm>
using namespace std;

// Function to normalize the board by translating it to the origin
vector<pair<int, int>> normalize(const vector<pair<int, int>>& pieces) {
    vector<pair<int, int>> normalized = pieces;
    int minX = INT_MAX, minY = INT_MAX;
    for (const auto& piece : pieces) {
        minX = min(minX, piece.first);
        minY = min(minY, piece.second);
    }
    for (auto& piece : normalized) {
        piece.first -= minX;
        piece.second -= minY;
    }
    sort(normalized.begin(), normalized.end());
    return normalized;
}

// Function to generate all transformations of the board
set<vector<pair<int, int>>> generateTransformations(const vector<pair<int, int>>& pieces, int W, int H) {
    set<vector<pair<int, int>>> transformations;
    vector<pair<int, int>> transformed = pieces;
    for (int i = 0; i < 4; ++i) {
        // Rotate 90 degrees
        for (auto& piece : transformed) {
            int temp = piece.first;
            piece.first = piece.second;
            piece.second = W - 1 - temp;
        }
        transformations.insert(normalize(transformed));
        // Reflect horizontally
        for (auto& piece : transformed) {
            piece.first = W - 1 - piece.first;
        }
        transformations.insert(normalize(transformed));
        // Reflect vertically
        for (auto& piece : transformed) {
            piece.second = H - 1 - piece.second;
        }
        transformations.insert(normalize(transformed));
    }
    return transformations;
}

int main() {
    int t; // Number of test cases
    cin >> t;
    while (t--) {
        int W, H, n; // Width, height, and number of pieces
        cin >> W >> H >> n;
        vector<pair<int, int>> board1(n), board2(n);
        for (int i = 0; i < n; ++i) {
            cin >> board1[i].first >> board1[i].second;
        }
        for (int i = 0; i < n; ++i) {
            cin >> board2[i].first >> board2[i].second;
        }
        // Generate all transformations for both boards
        auto transformations1 = generateTransformations(board1, W, H);
        auto transformations2 = generateTransformations(board2, W, H);
        // Check if there is any common transformation
        bool equivalent = false;
        for (const auto& trans : transformations1) {
            if (transformations2.count(trans)) {
                equivalent = true;
                break;
            }
        }
        cout << (equivalent ? "YES" : "NO") << endl;
    }
    return 0;
}
