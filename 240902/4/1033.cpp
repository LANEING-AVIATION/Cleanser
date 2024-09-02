/*
 * Problem: Defragment the disk by moving clusters to place files in optimal order.
 * Input: N (total clusters), K (number of files), followed by K lines each describing a file.
 * Output: Sequence of cluster-moving operations to achieve optimal placement.
 */

#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>

using namespace std;

struct File {
    int size;
    vector<int> clusters;
};

// Function to find the minimal number of cluster-moving operations
vector<pair<int, int>> defragmentDisk(int N, int K, vector<File>& files) {
    vector<pair<int, int>> moves;
    vector<int> disk(N + 1, 0); // 0 means free, >0 means occupied by a file
    unordered_map<int, int> clusterToFile;

    // Mark the initial positions of the files on the disk
    for (int i = 0; i < K; ++i) {
        for (int cluster : files[i].clusters) {
            disk[cluster] = i + 1;
            clusterToFile[cluster] = i;
        }
    }

    // Priority queue to manage free clusters
    priority_queue<int, vector<int>, greater<int>> freeClusters;
    for (int i = 1; i <= N; ++i) {
        if (disk[i] == 0) {
            freeClusters.push(i);
        }
    }

    // Move clusters to their optimal positions
    for (int i = 0; i < K; ++i) {
        int start = (i == 0) ? 1 : files[i - 1].clusters.back() + 1;
        for (int j = 0; j < files[i].size; ++j) {
            int target = start + j;
            if (disk[target] == 0) {
                disk[target] = i + 1;
                clusterToFile[target] = i;
            } else if (clusterToFile[target] != i) {
                int from = files[clusterToFile[target]].clusters.back();
                files[clusterToFile[target]].clusters.pop_back();
                moves.push_back({from, target});
                disk[target] = i + 1;
                clusterToFile[target] = i;
                freeClusters.push(from);
            }
        }
    }

    return moves;
}

int main() {
    int N, K;
    cin >> N >> K;
    vector<File> files(K);

    for (int i = 0; i < K; ++i) {
        cin >> files[i].size;
        files[i].clusters.resize(files[i].size);
        for (int j = 0; j < files[i].size; ++j) {
            cin >> files[i].clusters[j];
        }
    }

    vector<pair<int, int>> moves = defragmentDisk(N, K, files);

    if (moves.empty()) {
        cout << "No optimization needed" << endl;
    } else {
        for (const auto& move : moves) {
            cout << move.first << " " << move.second << endl;
        }
    }

    return 0;
}
