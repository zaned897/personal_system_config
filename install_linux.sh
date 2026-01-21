#!/bin/bash
# install_linux.sh - Versión Limpia con Symlinks

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "⬇️  1. Instalando herramientas..."
sudo apt update && sudo apt install -y git curl unzip zsh ripgrep fd-find gcc make build-essential
sudo snap install nvim --classic

if ! command -v zoxide &>/dev/null; then
  curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
fi
if ! command -v oh-my-posh &>/dev/null; then
  curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin
fi
if [ ! -d "$HOME/.fzf" ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --all
fi

echo "🔗 2. Vinculando configuraciones (Symlinks)..."

mkdir -p ~/.config

rm -rf ~/.config/nvim # Borramos cualquier config previa
ln -s "$BASE_DIR/nvim" ~/.config/nvim

ln -sf "$BASE_DIR/1_shell.omp.json" ~/.config/1_shell.omp.json

ln -sf "$BASE_DIR/.zshrc" ~/.zshrc
echo "✅ Listo. Todo está enlazado."
echo "   Cualquier cambio que hagas en ~/.config/nvim se guardará en tu repo."
