#ifndef MENU_HPP
#define MENU_HPP

#include <string>

// 🧩 Fonctions disponibles depuis menu.cpp
void afficherBanniere();                          // Affiche la bannière SMKORTEX
void lancerMenu();                                // Lancement du menu principal
void lancerScriptBoost(const std::string& path);  // Lance un script .sh via Boost.Process

#endif // MENU_HPP
