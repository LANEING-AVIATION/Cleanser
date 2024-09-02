// Problem: Determine if a square cake can be cut into specified square pieces without waste
#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

// Function to check if the cake can be cut into the specified pieces without waste
bool canCutCake(int s, const vector<int>& pieces) {
    int totalArea = s * s;
    int sumOfPieces = 0;
    for (int piece : pieces) {
        sumOfPieces += piece * piece;
    }
    return sumOfPieces == totalArea;
}

int main() {
    int t; // Number of test cases
    cin >> t;
    while (t--) {
        int s, n; // Side of the cake and number of pieces
        cin >> s >> n;
        vector<int> pieces(n);
        for (int i = 0; i < n; ++i) {
            cin >> pieces[i];
        }
        // Output result based on whether the cake can be cut without waste
        if (canCutCake(s, pieces)) {
            cout << "KHOOOOB!" << endl;
        } else {
            cout << "HUTUTU!" << endl;
        }
    }
    return 0;
}
