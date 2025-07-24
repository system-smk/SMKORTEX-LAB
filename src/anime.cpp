#include <iostream>
#include <cmath>
#include <chrono>
#include <thread>
#include <sys/ioctl.h>
#include <unistd.h>
#include <algorithm> // Pour std::max

// 📐 Récupérer les dimensions actuelles du terminal
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

// 🧼 Effacer le terminal
void nettoyerTerminal() {
    std::cout << "\033[2J\033[H"; // ANSI : efface tout + remet le curseur en haut
}

// 🔁 Dessiner le tunnel selon le temps
void dessinerTunnel(float temps, int largeur, int hauteur) {
    nettoyerTerminal();
    for (int y = 0; y < hauteur; ++y) {
        for (int x = 0; x < largeur; ++x) {
            float dx = x - largeur / 2;
            float dy = y - hauteur / 2;
            float distance = std::sqrt(dx * dx + dy * dy);
            float onde = std::sin(distance * 0.15f - temps);

            char pixel = ' ';
            if (onde > 0.85f)       pixel = '@';
            else if (onde > 0.65f)  pixel = '#';
            else if (onde > 0.4f)   pixel = '+';
            else if (onde > 0.2f)   pixel = '.';

            std::cout << pixel;
        }
        std::cout << "\n";
    }
}

// ✨ Affichage du splash centré, sans bordures
void afficherSplash() {
    nettoyerTerminal();
    int largeur = obtenirLargeurTerminal();

    std::string message = "⚡ SYSTÈME SMKORTEX ACTIF ⚡";

    int espacement = std::max(0, (largeur - static_cast<int>(message.size())) / 2);
    std::cout << "\n\n";
    std::cout << std::string(espacement, ' ') << message << "\n\n";
}

// 🚀 Point d’entrée principal
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
