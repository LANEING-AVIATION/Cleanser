// POJ-ICPC Problem: Encode message k times using a secret key
#include <iostream>
#include <vector>
#include <string>
using namespace std;

// Function to encode the message k times
string encodeMessage(const vector<int>& key, const string& message, int k) {
    int n = key.size();
    string encoded = message;
    for (int i = 0; i < k; ++i) {
        string temp = encoded;
        for (int j = 0; j < n; ++j) {
            encoded[key[j] - 1] = temp[j];
        }
    }
    return encoded;
}

int main() {
    int n;
    while (cin >> n && n != 0) {
        vector<int> key(n);
        for (int i = 0; i < n; ++i) {
            cin >> key[i];
        }
        cin.ignore(); // Ignore the newline after the key

        string line;
        while (getline(cin, line) && line != "0") {
            int k;
            string message;
            size_t pos = line.find(' ');
            k = stoi(line.substr(0, pos));
            message = line.substr(pos + 1);

            // Pad the message with spaces if it's shorter than n
            if (message.length() < n) {
                message.append(n - message.length(), ' ');
            }

            string encodedMessage = encodeMessage(key, message, k);
            cout << encodedMessage << endl;
        }
        cout << endl; // Separate blocks with an empty line
    }
    return 0;
}
