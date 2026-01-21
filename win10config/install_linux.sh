#!/bin/bash

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
echo "📂 Origen detectado: $BASE_DIR"

echo "⬇️  Instalando dependencias base..."
sudo apt update && sudo apt install -y git curl unzip zsh ripgrep fd-find gcc make
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

echo "🔗 Vinculando configuraciones..."

mkdir -p ~/.config
cp "$BASE_DIR/1_shell.omp.json" ~/.config/1_shell.omp.json

cp "$BASE_DIR/.zshrc" ~/.zshrc

mkdir -p ~/.config/nvim/lua

cp "$BASE_DIR/lua/init.lua" ~/.config/nvim/init.lua
cp "$BASE_DIR/lua/vim-options.lua" ~/.config/nvim/lua/
cp "$BASE_DIR/lua/vim-keymaps.lua" ~/.config/nvim/lua/

echo "✅ Instalación completada."
echo "⚠️  Ejecuta: 'sudo usermod -s /usr/bin/zsh ubuntu' si no se cambió la shell."
echo "🔄 Luego cierra sesión y vuelve a entrar."
