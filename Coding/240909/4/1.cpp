//in this section, the remote teamviewer connection was accidentally halted.
//To draw a conclusion of the previous 3 sections of development.
//I set up the basic simulation environment
//and I will extend 1 hour of coding in fix of the accident.

//fixed successfully,23:19
#include <iostream>
#include <iomanip>
#include <sstream>
#include <string>
#include <cmath>
#include <vector>

using namespace std;

// Helper function to remove trailing zeros
string removeTrailingZeros(const string& str) {
    size_t end = str.find_last_not_of('0');
    if (end != string::npos) {
        if (str[end] == '.') {
            end--;
        }
        return str.substr(0, end + 1);
    }
    return str;
}

int main() {
    string line;
    while (getline(cin, line)) {
        if (line.empty()) continue;

        stringstream ss(line);
        long double a;
        int b;
        ss >> a >> b;

        // Perform the exponentiation
        long double result = powl(a, b);

        // Convert the result to string with high precision
        stringstream resultStream;
        resultStream << setprecision(1100) << fixed << result;
        string resultStr = resultStream.str();

        // Remove trailing zeros
        resultStr = removeTrailingZeros(resultStr);

        // Print the result
        cout << resultStr << endl;
    }

    return 0;
}
