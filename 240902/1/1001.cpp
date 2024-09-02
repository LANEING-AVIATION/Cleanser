#include <iostream>
#include <iomanip>
#include <cmath>
using namespace std;

int main() {
    double R;
    int n;
    while (cin >> R >> n) {
        cout << fixed << setprecision(0) << pow(R, n) << endl;
    }
    return 0;
}
