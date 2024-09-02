// POJ Problem: Determine the year a property will begin eroding due to semicircular land loss

#include <iostream>
#include <cmath>

using namespace std;

int main() {
    int N; // Number of data sets
    cin >> N;
    for (int i = 1; i <= N; ++i) {
        double x, y;
        cin >> x >> y;
        
        // Calculate the distance from the origin to the point (x, y)
        double distance = sqrt(x * x + y * y);
        
        // Calculate the area of the semicircle that will be eroded each year
        double area = M_PI * distance * distance / 2.0;
        
        // Determine the year the property will begin eroding
        int year = static_cast<int>(area / 50.0) + 1;
        
        // Output the result in the required format
        cout << "Property " << i << ": This property will begin eroding in year " << year << "." << endl;
    }
    
    // Print the end of output statement
    cout << "END OF OUTPUT." << endl;
    
    return 0;
}
