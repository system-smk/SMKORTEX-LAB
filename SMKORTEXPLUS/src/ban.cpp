#include <iostream>
#include <cmath>
#include <chrono>
#include <thread>

const int width  = 80;
const int height = 24;
const int frames = 60; // durée de l'animation

void clearTerminal() {
    std::cout << "\x1b[2J\x1b[H"; // ANSI: clear + reset curseur
}

void drawTunnel(float t) {
    clearTerminal();
    for (int y = 0; y < height; ++y) {
        for (int x = 0; x < width; ++x) {
            float dx = x - width / 2;
            float dy = y - height / 2;
            float dist = std::sqrt(dx * dx + dy * dy);

            float wave = std::sin(dist * 0.15 - t);
            char pixel = ' ';
            if (wave > 0.85)       pixel = '@';
            else if (wave > 0.65)  pixel = '#';
            else if (wave > 0.4)   pixel = '+';
            else if (wave > 0.2)   pixel = '.';

            std::cout << pixel;
        }
        std::cout << "\n";
    }
}

void splashMessage() {
    clearTerminal();
    std::cout << "\n\n";
    std::cout << "╔══════════════════════════════════════════╗\n";
    std::cout << "║   🚀 SMKORTEX READY TO PULSE 🧠        ║\n";
    std::cout << "╚══════════════════════════════════════════╝\n";
    std::cout << "\n";
}

int main() {
    float t = 0.0f;
    for (int i = 0; i < frames; ++i) {
        drawTunnel(t);
        t += 0.15f;
        std::this_thread::sleep_for(std::chrono::milliseconds(50));
    }

    splashMessage();
    std::this_thread::sleep_for(std::chrono::seconds(2));
    return 0;
}
