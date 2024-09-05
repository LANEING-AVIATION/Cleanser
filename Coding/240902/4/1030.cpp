#include <iostream>
#include <vector>
#include <map>
#include <set>
#include <algorithm>

using namespace std;

struct Team {
    int id;
    int place1;
    int place2;
    bool participatedInBoth;
};

bool compareTeams(const Team &a, const Team &b) {
    if (a.participatedInBoth && b.participatedInBoth) {
        if (a.place1 < b.place1 && a.place2 <= b.place2) return true;
        if (a.place1 <= b.place1 && a.place2 < b.place2) return true;
        int diff1 = a.place1 - b.place1;
        int diff2 = b.place2 - a.place2;
        return diff1 > diff2;
    }
    return a.participatedInBoth > b.participatedInBoth;
}

int main() {
    vector<vector<int>> contest1 = {{9}, {7, 1, 4}, {5}, {1, 10}, {6}, {8}, {19}, {4, 20}, {21}};
    vector<vector<int>> contest2 = {{3}, {5}, {1, 10}, {15, 8}, {31, 18}, {9}, {17}, {19}, {4, 20}};

    map<int, Team> teams;

    for (int i = 0; i < contest1.size(); ++i) {
        for (int id : contest1[i]) {
            teams[id].id = id;
            teams[id].place1 = i + 1;
            teams[id].participatedInBoth = false;
        }
    }

    for (int i = 0; i < contest2.size(); ++i) {
        for (int id : contest2[i]) {
            teams[id].id = id;
            teams[id].place2 = i + 1;
            if (teams[id].place1 != 0) {
                teams[id].participatedInBoth = true;
            }
        }
    }

    vector<Team> teamList;
    for (auto &entry : teams) {
        teamList.push_back(entry.second);
    }

    sort(teamList.begin(), teamList.end(), compareTeams);

    for (const auto &team : teamList) {
        cout << "Team " << team.id << " Overall Place: " << (team.participatedInBoth ? "Both" : "One") << endl;
    }

    return 0;
}
