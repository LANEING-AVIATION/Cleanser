// Problem: Determine if a number can be represented in a given Fun number system
#include <iostream>
#include <string>
#include <vector>
using namespace std;

// Function to convert a number to its representation in the Fun number system
string convertToFunNumberSystem(int k, const string& system, long long N) {
    vector<char> result(k, '0');
    for (int i = k - 1; i >= 0; --i) {
        if (N & 1) {
            if (system[i] == 'n') {
                N += 1; // Adjust for negabit
            }
            result[i] = '1';
        }
        N >>= 1;
    }
    if (N != 0) {
        return "Impossible";
    }
    return string(result.begin(), result.end());
}

int main() {
    int t; // Number of test cases
    cin >> t;
    while (t--) {
        int k; // Number of bits
        cin >> k;
        string system; // Fun number system description
        cin >> system;
        long long N; // Number to be represented
        cin >> N;
        // Output the result of the conversion
        cout << convertToFunNumberSystem(k, system, N) << endl;
    }
    return 0;
}
