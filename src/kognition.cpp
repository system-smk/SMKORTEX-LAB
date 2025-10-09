#include <iostream>
#include <cmath>
#include <unistd.h>

int main() {
    const int width = 40, height = 20;
    float t = 0;

    while (true) {
        std::cout << "\033[2J\033[H"; // Clear screen
        float r = 6 + std::sin(t) * 2; // Rayon qui pulse

        // Affiche le message en haut
        std::cout << "\033[1;32mKORTEX génère du texte… patientez\033[0m\n\n";

        for (int y = -height/2; y < height/2; ++y) {
            for (int x = -width/2; x < width/2; ++x) {
                float dist = std::sqrt(x*x + y*y);
                if (std::abs(dist - r) < 1.0)
                    std::cout << "*";
                else
                    std::cout << " ";
            }
            std::cout << "\n";
        }

        t += 0.1;
        usleep(50000);
    }
}
