/*
 * Problem: Calculate the total illumination of a fence by a lamp at (0, 0).
 * The fence is a closed polygon with height h and vertices (Xi, Yi).
 * The illumination is given by the formula: dI = (k / r) * |cos(α)| * dl * h.
 */

#include <iostream>
#include <cmath>
#include <vector>

using namespace std;

struct Point {
    double x, y;
};

// Function to calculate the distance between two points
double distance(Point a, Point b) {
    return sqrt((a.x - b.x) * (a.x - b.y) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y));
}

// Function to calculate the dot product of two vectors
double dotProduct(Point a, Point b) {
    return a.x * b.x + a.y * b.y;
}

// Function to calculate the magnitude of a vector
double magnitude(Point a) {
    return sqrt(a.x * a.x + a.y * a.y);
}

// Function to calculate the total illumination of the fence
double totalIllumination(double k, double h, vector<Point>& vertices) {
    double totalIllumination = 0.0;
    int n = vertices.size();
    Point lamp = {0.0, 0.0};

    for (int i = 0; i < n; ++i) {
        Point p1 = vertices[i];
        Point p2 = vertices[(i + 1) % n];
        Point mid = {(p1.x + p2.x) / 2, (p1.y + p2.y) / 2};
        double r = distance(lamp, mid);
        Point normal = {p2.y - p1.y, p1.x - p2.x};
        double cosAlpha = dotProduct(normal, {mid.x - lamp.x, mid.y - lamp.y}) / (magnitude(normal) * magnitude({mid.x - lamp.x, mid.y - lamp.y}));
        double dl = distance(p1, p2);
        totalIllumination += (k / r) * fabs(cosAlpha) * dl * h;
    }

    return totalIllumination;
}

int main() {
    double k, h;
    int n;
    cin >> k >> h >> n;
    vector<Point> vertices(n);

    for (int i = 0; i < n; ++i) {
        cin >> vertices[i].x >> vertices[i].y;
    }

    double result = totalIllumination(k, h, vertices);
    printf("%.2f\n", result);

    return 0;
}
