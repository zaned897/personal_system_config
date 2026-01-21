#!/bin/bash
# install_linux.sh

sudo apt update && sudo apt install -y git curl unzip zsh ripgrep fd-find gcc make
sudo snap install nvim --classic

# 3. Instalar Zoxide and themes
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
curl -s https://ohmyposh.dev/install.sh | bash -s -- -d ~/.local/bin

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

mkdir -p ~/.config/zsh
mkdir -p ~/.config/nvim/lua

chsh -s $(which zsh)
