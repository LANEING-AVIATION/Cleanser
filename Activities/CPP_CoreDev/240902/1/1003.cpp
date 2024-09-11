// Problem: Calculate the minimum number of cards needed to achieve an overhang of at least 'c' card lengths.

#include <iostream>
using namespace std;

int main() {
    double c;
    while (cin >> c && c != 0.00) {
        double overhang = 0.0;
        int cards = 0;
        // Incrementally add card overhangs until the desired overhang 'c' is reached
        for (int i = 2; overhang < c; ++i) {
            overhang += 1.0 / i;
            ++cards;
        }
        // Output the result in the required format
        cout << cards << " card(s)" << endl;
    }
    return 0;
}
