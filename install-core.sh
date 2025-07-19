#!/bin/bash

echo -e "\n📦 Mise à jour du système..."
sudo apt update

echo -e "\n📦 Installation des packages..."
sudo apt install -y git cmake g++ wget build-essential libcurl4-openssl-dev ccache cmatrix tmux
