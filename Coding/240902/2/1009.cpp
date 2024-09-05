/*
 * Problem: Edge Detection using Run Length Encoding (RLE)
 * - Read a compressed image using RLE.
 * - Detect edges by finding the maximum absolute difference between a pixel and its neighbors.
 * - Output the edge-detected image in RLE format.
 */

#include <iostream>
#include <vector>
#include <cmath>
#include <algorithm>

using namespace std;

// Function to decode RLE to a flat image array
vector<int> decodeRLE(int width, const vector<pair<int, int>>& rle) {
    vector<int> image;
    for (const auto& p : rle) {
        image.insert(image.end(), p.second, p.first);
    }
    return image;
}

// Function to encode a flat image array to RLE
vector<pair<int, int>> encodeRLE(const vector<int>& image) {
    vector<pair<int, int>> rle;
    int n = image.size();
    for (int i = 0; i < n; ) {
        int value = image[i];
        int count = 0;
        while (i < n && image[i] == value) {
            ++count;
            ++i;
        }
        rle.emplace_back(value, count);
    }
    return rle;
}

// Function to perform edge detection on the image
vector<int> edgeDetection(const vector<int>& image, int width) {
    int height = image.size() / width;
    vector<int> edges(image.size(), 0);

    for (int y = 0; y < height; ++y) {
        for (int x = 0; x < width; ++x) {
            int maxDiff = 0;
            int currentPixel = image[y * width + x];

            // Check all 8 neighbors
            for (int dy = -1; dy <= 1; ++dy) {
                for (int dx = -1; dx <= 1; ++dx) {
                    if (dy == 0 && dx == 0) continue;
                    int ny = y + dy;
                    int nx = x + dx;
                    if (ny >= 0 && ny < height && nx >= 0 && nx < width) {
                        int neighborPixel = image[ny * width + nx];
                        maxDiff = max(maxDiff, abs(currentPixel - neighborPixel));
                    }
                }
            }
            edges[y * width + x] = maxDiff;
        }
    }
    return edges;
}

int main() {
    int width;
    while (cin >> width && width != 0) {
        vector<pair<int, int>> rle;
        int value, count;
        while (cin >> value >> count && (value != 0 || count != 0)) {
            rle.emplace_back(value, count);
        }

        // Decode the RLE to a flat image array
        vector<int> image = decodeRLE(width, rle);

        // Perform edge detection
        vector<int> edges = edgeDetection(image, width);

        // Encode the edge-detected image back to RLE
        vector<pair<int, int>> edgeRLE = encodeRLE(edges);

        // Output the edge-detected image in RLE format
        cout << width << endl;
        for (const auto& p : edgeRLE) {
            cout << p.first << " " << p.second << endl;
        }
        cout << "0 0" << endl;
    }
    cout << "0" << endl;
    return 0;
}
