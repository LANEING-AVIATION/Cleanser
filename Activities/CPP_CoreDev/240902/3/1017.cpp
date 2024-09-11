// POJ 1017: Packets
// Minimize the number of 6x6 parcels needed to deliver given packets of sizes 1x1 to 6x6

#include <iostream>
#include <cmath>

using namespace std;

int main() {
    int a, b, c, d, e, f;
    while (cin >> a >> b >> c >> d >> e >> f && (a || b || c || d || e || f)) {
        int parcels = f + e + d + (c + 3) / 4; // Each 6x6, 5x5, 4x4, and up to 4 3x3 need separate parcels

        int remaining2x2 = 5 * d + ((c % 4 == 3) ? 1 : (c % 4 == 2) ? 3 : (c % 4 == 1) ? 5 : 0);
        if (b > remaining2x2) {
            parcels += (b - remaining2x2 + 8) / 9;
        }

        int remaining1x1 = 36 * parcels - 36 * f - 25 * e - 16 * d - 9 * c - 4 * b;
        if (a > remaining1x1) {
            parcels += (a - remaining1x1 + 35) / 36;
        }

        cout << parcels << endl;
    }
    return 0;
}
