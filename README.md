

## 📄 `README.md` — Projet SMKORTEX


# 🧠 SMKORTEX

SMKORTEX est un **terminal IA local** conçu pour permettre à chacun d'interagir avec des modèles de langage en français — directement depuis sa machine.  
Ce projet est en **développement actif** 🚧 : l'arborescence évolue, le menu se muscle, et les neurones du terminal commencent à pulser.

## 📍 En construction

SMKORTEX est un cortex en évolution.  
---

## 🚀 Installation

Pour une **installation automatique**, lance simplement :

```bash
bash premiere_install.sh
```

Ce script :
- Installe tous les outils système nécessaires (CMake, Boost, etc.)
- Installe les modules IA 🧩 (`llamacpp`, `vigogne`)
- Compile le terminal C++
- Crée un lanceur simplifié nommé `kortexecute.sh`

👉 Une fois l’installation terminée :
```bash
./kortexecute.sh
```

---

## 📁 Structure du projet

```
smkortex/
├── premiere_install.sh       # Script d’installation automatique
├── kortexecute.sh            # Lanceur du terminal SMKORTEX
├── CMakeLists.txt            # Configuration CMake
├── src/                      # Sources C++
├── scripts/                  # Installation des modules IA
├── install/                  # Installation des outils système
└── build/                    # Compilation et exécutable
```

---

## 📚 Attribution et citation du modèle

SMKORTEX repose sur le modèle **Vigogne**, développé par @bofenghuang :

> Huang, B. (2023). Vigogne: French Instruction-following and Chat Models  
> GitHub repository → [https://github.com/bofenghuang/vigogne](https://github.com/bofenghuang/vigogne)

```bibtex
@misc{vigogne,
  author       = {Bofeng Huang},
  title        = {Vigogne: French Instruction-following and Chat Models},
  year         = {2023},
  publisher    = {GitHub},
  journal      = {GitHub repository},
  howpublished = {\url{https://github.com/bofenghuang/vigogne}},
}
```

🧠 **SMKORTEX powered by Vigogne** — modèle conversationnel français par [@bofenghuang](https://github.com/bofenghuang)

---

## 💚 Auteur

Projet pensé, organisé et piloté par **Mathieu-Karim**,  
assisté par **Copilot ✨** — ton compagnon de conception neuronale.

---




---



