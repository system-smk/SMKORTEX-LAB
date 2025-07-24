#include <iostream>
#include <filesystem>
#include <boost/process.hpp>
#include "dependances_kortex.hpp"

// 📦 Vérifie et exécute un script shell de façon sécurisée
bool lancerScriptBoost(const std::string& cheminScript) {
    if (!std::filesystem::exists(cheminScript)) {
        std::cout << "❌ Script non trouvé : " << cheminScript << "\n";
        return false;
    }

    std::cout << "🔹 Exécution sécurisée de : " << cheminScript << "\n";

    try {
        boost::process::child c(cheminScript);
        c.wait();

        if (c.exit_code() == 0) {
            std::cout << "✅ Script exécuté avec succès.\n";
            return true;
        } else {
            std::cout << "⚠️ Échec du script (code " << c.exit_code() << ")\n";
            return false;
        }

    } catch (const std::exception& e) {
        std::cout << "🔥 Erreur d’exécution : " << e.what() << "\n";
        return false;
    }
}

// 🔍 Fonction principale à appeler dans ton menu ou ton terminal
void installerDependancesIA() {
    std::cout << "\n╔════════════════════════════════════╗\n";
    std::cout << "║ 🔍 Vérification des dépendances IA ║\n";
    std::cout << "╚════════════════════════════════════╝\n";

    bool llamaOK = lancerScriptBoost("./llamacpp_install.sh");
    bool vigogneOK = lancerScriptBoost("./vigogne_install.sh");

    if (llamaOK && vigogneOK) {
        std::cout << "\n🎯 Toutes les dépendances IA sont installées.\n";
    } else {
        std::cout << "\n⚠️ Une ou plusieurs installations ont échoué.\n";
    }
}
