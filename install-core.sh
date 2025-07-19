#!/bin/bash

echo -e "\n📦 Mise à jour du système..."
sudo apt update

echo -e "\n📦 Installation des packages..."
sudo apt install -y git cmake wget build-essential libcurl4-openssl-dev ccache cmatrix tmux

echo -e "\n📥 Clonage du modèle llama.cpp..."
git clone https://github.com/ggerganov/llama.cpp.git || {
  echo "❌ Erreur lors du clonage de llama.cpp"
  exit 1
}

cd llama.cpp || {
  echo "❌ Dossier llama.cpp introuvable après clonage"
  exit 1
}

echo -e "\n🛠️ Compilation du modèle llama.cpp..."
make || {
  echo "❌ Échec de la compilation du modèle"
  exit 1
}

echo -e "\n✅ Modèle installé avec succès. Arrêt du cortex visuel..."
bash "$(dirname "$0")/ambienceur-stop.sh"

echo -e "\n💬 Lancement du moteur RAG..."
bash "$(dirname "$0")/rag-agent.sh"
