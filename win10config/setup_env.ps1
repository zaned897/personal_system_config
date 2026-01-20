# Bin instalation

winget install JanDedobbeleer.OhMyPosh -s winget
winget install ajeetdsouza.zoxide
winget install junegunn.fzf
winget install Neovim.Neovim
winget install Git.Git

#Font instalation
winget install RyanL.MesloLGNF

# Powershell modules

Install-Module posh-git -Scope CurrentUser -Force
Install-Module Terminal-Icons -Scope CurrentUser -Force
Install-Module PSFzf -Scope CurrentUser -Force
Install-Module PSReadLine -AllowPrerelease -Force

