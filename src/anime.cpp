#include <iostream>
#include <cmath>
#include <chrono>
#include <thread>
#include <sys/ioctl.h>
#include <unistd.h>

// 📐 Récupérer la taille du terminal
int obtenirLargeurTerminal() {
    struct winsize taille;
    ioctl(STDOUT_FILENO, TIOCGWINSZ, &taille);
    return taille.ws_col;
}

int obtenirHauteurTerminal() {
    struct winsize taille;
    ioctl(STDOUT_FILENO, TIOCGWINSZ, &taille);
    return taille.ws_row;
}

// 🔄 Nettoyer le terminal
void nettoyerTerminal() {
    std::cout << "\033[2J\033[H";
}

// 🔁 Dessiner le tunnel
void dessinerTunnel(float temps, int largeur, int hauteur) {
    nettoyerTerminal();
    for (int y = 0; y < hauteur; ++y) {
        for (int x = 0; x < largeur; ++x) {
            float dx = x - largeur / 2;
            float dy = y - hauteur / 2;
            float dist = std::sqrt(dx * dx + dy * dy);

            float onde = std::sin(dist * 0.15 - temps);
            char pixel = ' ';
            if (onde > 0.85)      pixel = '@';
            else if (onde > 0.65) pixel = '#';
            else if (onde > 0.4)  pixel = '+';
            else if (onde > 0.2)  pixel = '.';

            std::cout << pixel;
        }
        std::cout << "\n";
    }
}

// ✨ Affichage du message final
void afficherSplash() {
    nettoyerTerminal();
    std::cout << "\n\n";
    std::cout << "╔══════════════════════════════════════════╗\n";
    std::cout << "         ⚡ SYSTÈME SMKORTEX ACTIF ⚡       \n";
    std::cout << "╚══════════════════════════════════════════╝\n";
    std::cout << "\n";
}

// 🧠 Entrée principale
int main() {
    int largeur = obtenirLargeurTerminal();
    int hauteur = obtenirHauteurTerminal();
    const int nombreFrames = 60;
    float t = 0.0f;

    for (int i = 0; i < nombreFrames; ++i) {
        dessinerTunnel(t, largeur, hauteur);
        t += 0.15f;
        std::this_thread::sleep_for(std::chrono::milliseconds(50));
    }

    afficherSplash();
    std::this_thread::sleep_for(std::chrono::seconds(2));
    return 0;
}
