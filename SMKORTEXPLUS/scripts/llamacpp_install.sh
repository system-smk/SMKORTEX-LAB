#!/bin/bash

echo "🧠 Installation de llama.cpp — moteur IA local"

# Vérification des outils nécessaires
for cmd in git cmake make g++; do
    if ! command -v $cmd &> /dev/null; then
        echo "❌ $cmd non trouvé. Installe-le avant de continuer."
        exit 1
    fi
done

# Clonage du dépôt
if [ ! -d "llama.cpp" ]; then
    echo "📦 Clonage du dépôt llama.cpp..."
    git clone https://github.com/ggerganov/llama.cpp.git || exit 1
else
    echo "🌀 llama.cpp déjà présent."
fi

# Compilation
cd llama.cpp
mkdir -p build
echo "⚙️ Compilation en cours..."
cmake -B build -DCMAKE_BUILD_TYPE=Release
cmake --build build --config Release || exit 1

echo "✅ llama.cpp installé et compilé."
exit 0
