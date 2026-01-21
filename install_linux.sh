#!/bin/bash
# install_linux.sh (Ubicado en la raíz del repo)

# Detectamos la ruta donde está este script (la raíz del repo)
REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
# Definimos dónde están los archivos reales
SOURCE_DIR="$REPO_ROOT/win10config"

echo "📂 Raíz del repo: $REPO_ROOT"
echo "📂 Origen de configs: $SOURCE_DIR"

echo "⬇️  1. Instalando herramientas..."
sudo apt update && sudo apt install -y git curl unzip zsh ripgrep fd-find gcc make build-essential
sudo snap install nvim --classic

# Instaladores condicionales
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

# A. Neovim
# Enlazamos la carpeta nvim que está DENTRO de win10config
rm -rf ~/.config/nvim
ln -s "$SOURCE_DIR/nvim" ~/.config/nvim

# B. Oh My Posh
# Usamos el json que está DENTRO de win10config
ln -sf "$SOURCE_DIR/1_shell.omp.json" ~/.config/1_shell.omp.json

# C. Zshrc
# Usamos el .zshrc que está DENTRO de win10config
ln -sf "$SOURCE_DIR/.zshrc" ~/.zshrc

echo "✅ Listo. Todo está enlazado apuntando a $SOURCE_DIR."
