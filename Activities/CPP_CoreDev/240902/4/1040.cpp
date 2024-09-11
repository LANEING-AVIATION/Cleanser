// POJ 1040: Determine the actual year given computer bugs

#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

struct Computer {
    int y, a, b;
};

// Function to find the smallest possible year
int findYear(const vector<Computer>& computers) {
    int year = 0;
    for (const auto& comp : computers) {
        year = max(year, comp.a);
    }

    while (year < 10000) {
        bool valid = true;
        for (const auto& comp : computers) {
            int displayedYear = (year >= comp.b) ? comp.a + (year - comp.b) : year;
            if (displayedYear != comp.y) {
                valid = false;
                break;
            }
        }
        if (valid) return year;
        ++year;
    }
    return -1;
}

int main() {
    int n, caseNum = 1;
    while (cin >> n && n != 0) {
        vector<Computer> computers(n);
        for (int i = 0; i < n; ++i) {
            cin >> computers[i].y >> computers[i].a >> computers[i].b;
        }

        int result = findYear(computers);
        cout << "Case #" << caseNum++ << ":\n";
        if (result == -1) {
            cout << "Unknown bugs detected.\n";
        } else {
            cout << "The actual year is " << result << ".\n";
        }
        cout << endl;
    }
    return 0;
}
