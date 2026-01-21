# ~/.zshrc

# 1. FIX CRÍTICO DEL PATH (Zoxide y OMP viven aquí)
export PATH=$HOME/.local/bin:$PATH

# 2. Oh My Posh
eval "$(oh-my-posh init zsh --config $HOME/.config/1_shell.omp.json)"

# 3. Zoxide
eval "$(zoxide init zsh)"

# 4. FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f'

# 5. Alias Windows -> Linux
alias vim="nvim"
alias ll="ls -la --color=auto"
alias g="git"
alias c="z"
alias d="docker"
alias dps="docker ps"
alias dco="docker compose"

# 6. Bindings
bindkey -v

