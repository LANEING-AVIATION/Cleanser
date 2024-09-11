#include <iostream>
#include <stack>
#include <string>

using namespace std;

int main() {
    stack<string> backStack, forwardStack;
    string current = "http://www.acm.org/";
    string command, url;

    while (cin >> command) {
        if (command == "VISIT") {
            cin >> url;
            backStack.push(current);
            current = url;
            while (!forwardStack.empty()) forwardStack.pop();
            cout << current << endl;
        } else if (command == "BACK") {
            if (backStack.empty()) {
                cout << "Ignored" << endl;
            } else {
                forwardStack.push(current);
                current = backStack.top();
                backStack.pop();
                cout << current << endl;
            }
        } else if (command == "FORWARD") {
            if (forwardStack.empty()) {
                cout << "Ignored" << endl;
            } else {
                backStack.push(current);
                current = forwardStack.top();
                forwardStack.pop();
                cout << current << endl;
            }
        } else if (command == "QUIT") {
            break;
        }
    }

    return 0;
}
