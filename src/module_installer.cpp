#include <iostream>
#include <filesystem>
#include <boost/process.hpp>

namespace fs = std::filesystem;
namespace bp = boost::process;

int main() {
    std::cout << "🧠 SMKORTEX — Installation des modules IA\n";

    // 📁 Création des dossiers nécessaires
    fs::create_directories("repos");
    fs::create_directories("models");

    // 📦 Clonage de llama.cpp
    std::string llama_dir = "repos/llama.cpp";
    if (!fs::exists(llama_dir)) {
        std::cout << "📥 Clonage de llama.cpp...\n";
        bp::system("/usr/bin/git", bp::args={"clone", "https://github.com/ggerganov/llama.cpp.git", llama_dir});
    } else {
        std::cout << "✅ llama.cpp déjà présent : " << llama_dir << "\n";
    }

    // 📥 Téléchargement du modèle Vigogne
    std::string model_path = "models/vigogne-2-7b-chat.Q4_K_M.gguf";
    if (!fs::exists(model_path)) {
        std::cout << "📦 Téléchargement du modèle Vigogne (.gguf)...\n";
        bp::system("/usr/bin/curl", bp::args={
            "-L",
            "https://huggingface.co/TheBloke/Vigogne-2-7B-Chat-GGUF/resolve/main/vigogne-2-7b-chat.Q4_K_M.gguf",
            "-o",
            model_path
        });
    } else {
        std::cout << "✅ Modèle déjà téléchargé : " << model_path << "\n";
    }

    std::cout << "\n🚀 Modules installés — Ton cortex est prêt à interagir 🧩\n";
    return 0;
}
