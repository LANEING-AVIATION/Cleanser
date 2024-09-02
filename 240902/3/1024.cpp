// Problem: Verify if the given output for the maze problem is correct
#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>
using namespace std;

// Function to check if the given path is the unique shortest path in the maze
bool isUniqueShortestPath(int W, int H, const string& path, const vector<pair<int, int>>& walls) {
    // Create a set to store the walls
    unordered_set<string> wallSet;
    for (const auto& wall : walls) {
        wallSet.insert(to_string(wall.first) + "," + to_string(wall.second));
    }

    // Simulate the path and check for uniqueness
    int x = 0, y = 0;
    for (char move : path) {
        int nx = x, ny = y;
        if (move == 'U') ny++;
        else if (move == 'D') ny--;
        else if (move == 'L') nx--;
        else if (move == 'R') nx++;
        if (wallSet.count(to_string(x) + "," + to_string(y) + "-" + to_string(nx) + "," + to_string(ny)) ||
            wallSet.count(to_string(nx) + "," + to_string(ny) + "-" + to_string(x) + "," + to_string(y))) {
            return false; // Path is blocked by a wall
        }
        x = nx;
        y = ny;
    }
    return true;
}

int main() {
    int t; // Number of test cases
    cin >> t;
    while (t--) {
        int W, H; // Width and height of the grid
        cin >> W >> H;
        string path; // Path in the maze
        cin >> path;
        int M; // Number of walls
        cin >> M;
        vector<pair<int, int>> walls(M);
        for (int i = 0; i < M; ++i) {
            int x1, y1, x2, y2;
            cin >> x1 >> y1 >> x2 >> y2;
            walls[i] = {x1 * H + y1, x2 * H + y2};
        }
        // Output the result of the verification
        cout << (isUniqueShortestPath(W, H, path, walls) ? "CORRECT" : "INCORRECT") << endl;
    }
    return 0;
}
