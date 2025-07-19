#!/bin/bash
# === 🧠 rag-engine.sh : moteur de requête SMKORTEX local

ROOTDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LLAMA_BIN="$ROOTDIR/llama.cpp/main"
MODEL_PATH="$ROOTDIR/models/vigogne-q4_0.gguf"

clear
echo "---------------------------------------------"
figlet "SMKORTEX"
echo "🧠 Moteur Cognitif Local Initialisé"
echo "---------------------------------------------"

# ✅ Vérification du modèle
if [[ ! -f "$MODEL_PATH" ]]; then
  echo "❌ Modèle introuvable ➤ attendu à : $MODEL_PATH"
  echo "💡 Télécharge-le ou place-le ici avant de continuer"
  exit 1
fi

# ✅ Vérification du binaire
if [[ ! -x "$LLAMA_BIN" ]]; then
  echo "❌ Binaire non compilé ➤ attendu à : $LLAMA_BIN"
  echo "💡 Compile avec 'make' dans llama.cpp si besoin"
  exit 1
fi

# 🎤 Boucle interactive de requête
echo -e "\n💬 SMKORTEX est prêt. Tape une requête ou 'exit' pour quitter :"
while true; do
  read -p "🧠➤ " QUERY
  [[ "$QUERY" == "exit" ]] && break

  echo "🔎 Traitement de la requête..."
  
  # ⚙️ Simulation de réponse (à personnaliser)
  "$LLAMA_BIN" -m "$MODEL_PATH" -p "$QUERY" | head -n 20
  echo -e "\n🌐 Requête terminée — tape une nouvelle question ou 'exit'"
done

echo -e "\n🧘 Session SMKORTEX terminée. À bientôt, cortex shell 💚"

