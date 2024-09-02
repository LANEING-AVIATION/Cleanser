/*
 * Problem: Find the dog's route that maximizes the number of interesting places visited.
 * Input: N (number of points in Bob's route), M (number of interesting places), followed by coordinates of Bob's route and interesting places.
 * Output: Number of vertices in the best dog's route and the coordinates of this route.
 */

#include <iostream>
#include <vector>
#include <cmath>
#include <algorithm>

using namespace std;

struct Point {
    int x, y;
};

// Function to calculate the distance between two points
double distance(Point a, Point b) {
    return sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y));
}

// Function to check if the dog can visit an interesting place and return to Bob in time
bool canVisit(Point start, Point end, Point interesting) {
    return distance(start, interesting) + distance(interesting, end) <= 2 * distance(start, end);
}

int main() {
    int N, M;
    cin >> N >> M;
    vector<Point> bobRoute(N);
    vector<Point> interestingPlaces(M);

    for (int i = 0; i < N; ++i) {
        cin >> bobRoute[i].x >> bobRoute[i].y;
    }

    for (int i = 0; i < M; ++i) {
        cin >> interestingPlaces[i].x >> interestingPlaces[i].y;
    }

    vector<Point> dogRoute;
    dogRoute.push_back(bobRoute[0]);

    for (int i = 0; i < N - 1; ++i) {
        Point start = bobRoute[i];
        Point end = bobRoute[i + 1];
        Point bestPlace = {0, 0};
        bool found = false;

        for (const auto& place : interestingPlaces) {
            if (canVisit(start, end, place)) {
                bestPlace = place;
                found = true;
                break;
            }
        }

        if (found) {
            dogRoute.push_back(bestPlace);
        }
        dogRoute.push_back(end);
    }

    cout << dogRoute.size() << endl;
    for (const auto& point : dogRoute) {
        cout << point.x << " " << point.y << endl;
    }

    return 0;
}
