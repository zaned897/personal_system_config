#!/bin/bash
set -e

REPO_ROOT="$(cd "$(dirname "$0")" && pwd)"
SOURCE_DIR="$REPO_ROOT/win10config"
LOCAL_BIN="$HOME/.local/bin"

NVIM_VERSION="v0.11.2"
NVIM_DIR="$HOME/.local/nvim-$NVIM_VERSION"

mkdir -p "$LOCAL_BIN"
export PATH="$LOCAL_BIN:$PATH"

echo "Bootstrap from: $REPO_ROOT"

echo "Installing dependencies..."

sudo apt update && sudo apt install -y git curl wget unzip zsh ripgrep fd-find gcc make build-essential python3-pip python3-venv python3-pynvim

if ! command -v fd &>/dev/null; then
  ln -sf "$(which fdfind)" "$LOCAL_BIN/fd"
  echo "Alias created: fd -> fdfind"
fi

if ! command -v node &>/dev/null; then
  echo "Installing Node.js & NPM..."
  curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
  sudo apt-get install -y nodejs
fi

if ! npm list -g neovim &>/dev/null; then
  echo "Installing Neovim NPM provider..."
  sudo npm install -g neovim
fi

if ! command -v tree-sitter &>/dev/null; then
  echo "Installing Tree-sitter CLI..."
  sudo npm install -g tree-sitter-cli
fi

if ! command -v lazygit &>/dev/null; then
  echo "Installing Lazygit..."
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit /usr/local/bin
  rm lazygit lazygit.tar.gz
fi

echo "Installing Neovim"
cd /tmp
wget -O nvim.tar.gz https://github.com/neovim/neovim/releases/download/$NVIM_VERSION/nvim-linux-x86_64.tar.gz
tar xzf nvim.tar.gz

rm -rf "$NVIM_DIR"
mv nvim-linux-x86_64 "$NVIM_DIR"
ln -sf "$NVIM_DIR/bin/nvim" "$LOCAL_BIN/nvim"
rm nvim.tar.gz

if ! command -v zoxide &>/dev/null; then
  curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
fi

if ! command -v oh-my-posh &>/dev/null; then
  curl -s https://ohmyposh.dev/install.sh | bash -s -- -d "$LOCAL_BIN"
fi

if [ ! -d "$HOME/.fzf" ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --all --no-update-rc
fi

echo "Appling configurations..."

link_with_backup() {
  local src="$1"
  local dest="$2"

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    if [ ! -L "$dest" ]; then
      echo "Backup created ${dest}.bak"
      mv "$dest" "${dest}.bak"
    else
      rm "$dest"
    fi
  fi
  ln -s "$src" "$dest"
}

mkdir -p ~/.config
link_with_backup "$SOURCE_DIR/nvim" ~/.config/nvim
link_with_backup "$SOURCE_DIR/1_shell.omp.json" ~/.config/1_shell.omp.json
link_with_backup "$SOURCE_DIR/.zshrc" ~/.zshrc

CURRENT_SHELL=$(basename "$SHELL")
if [ "$CURRENT_SHELL" != "zsh" ]; then
  echo "Changing default shell to zsh"
  ZSH_PATH=$(which zsh)
  sudo chsh -s "$ZSH_PATH" "$USER"
fi

echo "Installation complete"
