// POJ 1039: Determine the farthest point light can reach in a bent pipe

#include <iostream>
#include <iomanip>
#include <cmath>
#include <vector>

using namespace std;

struct Point {
    double x, y;
};

// Function to check if the light can pass through the pipe
bool canPass(const Point &a, const Point &b, const vector<Point> &up, const vector<Point> &down) {
    for (size_t i = 0; i < up.size(); ++i) {
        double y = (b.y - a.y) * (up[i].x - a.x) / (b.x - a.x) + a.y;
        if (y < down[i].y || y > up[i].y) {
            return false;
        }
    }
    return true;
}

int main() {
    int n;
    while (cin >> n && n != 0) {
        vector<Point> up(n), down(n);
        for (int i = 0; i < n; ++i) {
            cin >> up[i].x >> up[i].y;
            down[i].x = up[i].x;
            down[i].y = up[i].y - 1;
        }

        double maxX = up[0].x;
        bool throughAll = false;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (canPass(up[i], down[j], up, down)) {
                    maxX = max(maxX, up[i].x);
                    if (up[i].x == up.back().x) {
                        throughAll = true;
                    }
                }
            }
        }

        if (throughAll) {
            cout << "Through all the pipe." << endl;
        } else {
            cout << fixed << setprecision(2) << maxX << endl;
        }
    }
    return 0;
}
