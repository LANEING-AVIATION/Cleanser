#include <iostream>
#include <string>
#include <unordered_map>
using namespace std;

// Haab month names
const string haabMonths[] = {"pop", "no", "zip", "zotz", "tzec", "xul", "yoxkin", "mol", "chen", "yax", "zac", "ceh", "mac", "kankin", "muan", "pax", "koyab", "cumhu", "uayet"};
// Tzolkin day names
const string tzolkinDays[] = {"imix", "ik", "akbal", "kan", "chicchan", "cimi", "manik", "lamat", "muluk", "ok", "chuen", "eb", "ben", "ix", "mem", "cib", "caban", "eznab", "canac", "ahau"};

int main() {
    int n;
    cin >> n;
    cout << n << endl;

    unordered_map<string, int> haabMonthMap;
    for (int i = 0; i < 19; ++i) {
        haabMonthMap[haabMonths[i]] = i;
    }

    for (int i = 0; i < n; ++i) {
        int haabDay, haabYear;
        string haabMonth;
        char dot;
        cin >> haabDay >> dot >> haabMonth >> haabYear;

        int totalDays = haabYear * 365 + haabMonthMap[haabMonth] * 20 + haabDay;

        int tzolkinYear = totalDays / 260;
        int tzolkinDayNumber = totalDays % 260;
        int tzolkinDay = tzolkinDayNumber % 13 + 1;
        string tzolkinDayName = tzolkinDays[tzolkinDayNumber % 20];

        cout << tzolkinDay << " " << tzolkinDayName << " " << tzolkinYear << endl;
    }

    return 0;
}
