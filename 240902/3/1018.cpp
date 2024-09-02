// POJ 1018: Communication System
// Maximize B/P where B is the minimum bandwidth and P is the total price

#include <iostream>
#include <vector>
#include <algorithm>
#include <iomanip>

using namespace std;

struct Device {
    int bandwidth, price;
};

double maximizeBP(int n, vector<vector<Device>> &devices) {
    double maxRatio = 0.0;
    for (int i = 0; i < n; ++i) {
        for (const auto &d : devices[i]) {
            double B = d.bandwidth;
            double P = d.price;
            for (int j = 0; j < n; ++j) {
                if (i == j) continue;
                double minB = B;
                double totalP = P;
                for (const auto &dj : devices[j]) {
                    if (dj.bandwidth >= minB) {
                        totalP += dj.price;
                        break;
                    }
                }
            }
            maxRatio = max(maxRatio, B / P);
        }
    }
    return maxRatio;
}

int main() {
    int t;
    cin >> t;
    while (t--) {
        int n;
        cin >> n;
        vector<vector<Device>> devices(n);
        for (int i = 0; i < n; ++i) {
            int mi;
            cin >> mi;
            devices[i].resize(mi);
            for (int j = 0; j < mi; ++j) {
                cin >> devices[i][j].bandwidth >> devices[i][j].price;
            }
        }
        double result = maximizeBP(n, devices);
        cout << fixed << setprecision(3) << result << endl;
    }
    return 0;
}
