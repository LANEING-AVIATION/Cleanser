// POJ Problem: Determine the next triple peak in biorhythms

#include <iostream>
using namespace std;

const int PHYSICAL_CYCLE = 23;
const int EMOTIONAL_CYCLE = 28;
const int INTELLECTUAL_CYCLE = 33;
const int CYCLE_PERIOD = PHYSICAL_CYCLE * EMOTIONAL_CYCLE * INTELLECTUAL_CYCLE;

int main() {
    int p, e, i, d;
    int caseNumber = 1;
    
    while (cin >> p >> e >> i >> d) {
        if (p == -1 && e == -1 && i == -1 && d == -1) break;
        
        int days = (5544 * p + 14421 * e + 1288 * i - d) % CYCLE_PERIOD;
        if (days <= 0) days += CYCLE_PERIOD;
        
        cout << "Case " << caseNumber++ << ": the next triple peak occurs in " << days << " days." << endl;
    }
    
    return 0;
}
