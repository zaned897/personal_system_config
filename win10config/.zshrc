# ~/.zshrc (Equivalente a user_profile.ps1)

export PATH=$HOME/.local/bin:$HOME/.cargo/bin:$PATH

eval "$(oh-my-posh init zsh --config $HOME/.config/1_shell.omp.json)"

eval "$(zoxide init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f'

alias vim="nvim"
alias ll="ls -la --color=auto"
alias g="git"
alias grep="grep --color=auto"
alias hk="heroku"
alias c="z"

alias d="docker"
alias dps="docker ps"
alias dco="docker compose"

bindkey -v

