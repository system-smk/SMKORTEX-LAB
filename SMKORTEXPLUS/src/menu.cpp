#include <iostream>
#include <boost/process.hpp>
#include <filesystem>
#include "menu.hpp"
#include "dependances_kortex.hpp"

// 🔧 Fonction de lancement d’un script avec Boost.Process
void lancerScriptBoost(const std::string& cheminScript) {
    if (!std::filesystem::exists(cheminScript)) {
        std::cout << "❌ Script non trouvé : " << cheminScript << "\n";
        return;
    }

    try {
        std::cout << "🔧 Lancement : " << cheminScript << "\n";
        boost::process::child proc(cheminScript);
        proc.wait();

        if (proc.exit_code() == 0) {
            std::cout << "✅ Script exécuté avec succès.\n";
        } else {
            std::cout << "⚠️ Code de sortie : " << proc.exit_code() << "\n";
        }
    } catch (const std::exception& e) {
        std::cout << "🔥 Erreur Boost.Process : " << e.what() << "\n";
    }
}

// 🧠 Fonction du menu SMKORTEX
void lancerMenu() {
    int choix = -1;

    while (choix != 0) {
        std::cout << "\n📋 Menu principal SMKORTEX :\n";
        std::cout << "1. 🔍 Installer dépendances IA (llama.cpp + Vigogne)\n";
        std::cout << "2. 📦 Outils système (Git, Curl, Boost...)\n";
        std::cout << "0. ❌ Quitter\n";
        std::cout << "➤ Choix : ";
        std::cin >> choix;

        switch (choix) {
            case 1:
                installerDependancesKortex();
                break;

            case 2:
                lancerScriptBoost("./install/tools_base_install.sh");
                break;

            case 0:
                std::cout << "👋 À bientôt, cortex maître.\n";
                break;

            default:
                std::cout << "❌ Option invalide.\n";
        }
    }
}
