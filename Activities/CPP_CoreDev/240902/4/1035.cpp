/*
 * Problem: Spell checker that suggests corrections for misspelled words.
 * Input: Dictionary of correct words followed by words to be checked.
 * Output: For each word, either "is correct" or possible corrections.
 */

#include <iostream>
#include <vector>
#include <unordered_set>
#include <unordered_map>
#include <string>
#include <algorithm>

using namespace std;

// Function to check if two words differ by exactly one character
bool oneCharDiff(const string& a, const string& b) {
    if (a.size() != b.size()) return false;
    int diffCount = 0;
    for (size_t i = 0; i < a.size(); ++i) {
        if (a[i] != b[i]) {
            if (++diffCount > 1) return false;
        }
    }
    return diffCount == 1;
}

// Function to generate all possible words by deleting one character
vector<string> generateDeletes(const string& word) {
    vector<string> deletes;
    for (size_t i = 0; i < word.size(); ++i) {
        string temp = word;
        temp.erase(i, 1);
        deletes.push_back(temp);
    }
    return deletes;
}

// Function to generate all possible words by inserting one character
vector<string> generateInserts(const string& word) {
    vector<string> inserts;
    for (size_t i = 0; i <= word.size(); ++i) {
        for (char c = 'a'; c <= 'z'; ++c) {
            string temp = word;
            temp.insert(temp.begin() + i, c);
            inserts.push_back(temp);
        }
    }
    return inserts;
}

int main() {
    unordered_set<string> dictionary;
    string word;

    // Read dictionary words
    while (cin >> word && word != "#") {
        dictionary.insert(word);
    }

    // Read words to be checked
    vector<string> wordsToCheck;
    while (cin >> word && word != "#") {
        wordsToCheck.push_back(word);
    }

    // Process each word to be checked
    for (const auto& word : wordsToCheck) {
        if (dictionary.find(word) != dictionary.end()) {
            cout << word << " is correct" << endl;
        } else {
            vector<string> suggestions;

            // Check for words with one character difference
            for (const auto& dictWord : dictionary) {
                if (oneCharDiff(word, dictWord)) {
                    suggestions.push_back(dictWord);
                }
            }

            // Check for words by deleting one character
            vector<string> deletes = generateDeletes(word);
            for (const auto& delWord : deletes) {
                if (dictionary.find(delWord) != dictionary.end()) {
                    suggestions.push_back(delWord);
                }
            }

            // Check for words by inserting one character
            vector<string> inserts = generateInserts(word);
            for (const auto& insWord : inserts) {
                if (dictionary.find(insWord) != dictionary.end()) {
                    suggestions.push_back(insWord);
                }
            }

            // Output the results
            cout << word << ":";
            if (suggestions.empty()) {
                cout << endl;
            } else {
                for (const auto& suggestion : suggestions) {
                    cout << " " << suggestion;
                }
                cout << endl;
            }
        }
    }

    return 0;
}
