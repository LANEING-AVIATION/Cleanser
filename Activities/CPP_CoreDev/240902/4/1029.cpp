#include <iostream>
#include <vector>
#include <string>
#include <set>

using namespace std;

int main() {
    int N, K;
    cin >> N >> K;
    vector<set<int>> left(K), right(K);
    vector<char> result(K);
    set<int> possible;
    for (int i = 1; i <= N; ++i) {
        possible.insert(i);
    }

    for (int i = 0; i < K; ++i) {
        int P;
        cin >> P;
        for (int j = 0; j < P; ++j) {
            int coin;
            cin >> coin;
            left[i].insert(coin);
        }
        for (int j = 0; j < P; ++j) {
            int coin;
            cin >> coin;
            right[i].insert(coin);
        }
        cin >> result[i];
    }

    for (int i = 0; i < K; ++i) {
        if (result[i] == '=') {
            for (int coin : left[i]) {
                possible.erase(coin);
            }
            for (int coin : right[i]) {
                possible.erase(coin);
            }
        }
    }

    for (int i = 0; i < K; ++i) {
        if (result[i] != '=') {
            set<int> temp;
            for (int coin : left[i]) {
                if (possible.count(coin)) {
                    temp.insert(coin);
                }
            }
            for (int coin : right[i]) {
                if (possible.count(coin)) {
                    temp.insert(coin);
                }
            }
            possible = temp;
        }
    }

    if (possible.size() == 1) {
        cout << *possible.begin() << endl;
    } else {
        cout << 0 << endl;
    }

    return 0;
}
