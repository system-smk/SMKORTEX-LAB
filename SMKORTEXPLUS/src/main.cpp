#include <iostream>
#include <thread>
#include <cmath>
#include <cstdlib>

const int width = 120;
const int height = 60;

void clearScreen() {
    std::cout << "\x1b[2J\x1b[H"; // Clear terminal
}

void drawTunnel(float t) {
    clearScreen();
    for (int y = 0; y < height; ++y) {
        for (int x = 0; x < width; ++x) {
            float dx = x - width / 2;
            float dy = y - height / 2;
            float dist = std::sqrt(dx*dx + dy*dy);

            std::string c = " ";
            float wave = std::sin(dist * 0.2 - t);
            if (wave > 0.8) c = "S";
            else if (wave > 0.5) c = "M";
            else if (wave > 0.2) c = "K";

            std::cout << c;
        }
        std::cout << "\n";
    }
}

int main() {
    float time = 0.0;
    while (true) {
        drawTunnel(time);
        time += 0.15;
        std::this_thread::sleep_for(std::chrono::milliseconds(50));
    }
}
