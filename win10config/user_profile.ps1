# ─────────────────────────────────────────────────
# Microsoft.PowerShell_profile.ps1 (limpio)
# ─────────────────────────────────────────────────

# 1) Codificación UTF-8
[console]::InputEncoding  = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

# 2) posh-git + oh-my-posh
Import-Module posh-git

$omp_config = "$env:USERPROFILE\.config\powershell\1_shell.omp.json"
# Fragile path for posh themes path
#$omp_config = "$env:POSH_THEMES_PATH\1_shell.omp.json"
oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression

# 2.1) Zoxide Alias
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# 3) Terminal-Icons
Import-Module Terminal-Icons


# 4) ViMode
Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History


# 5) Fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f'
Set-PsFzfOption -PSReadlineChordReverseHistory 'Ctrl+r'

# 6) Variables de entorno
$env:GIT_SSH = 'C:\Windows\system32\OpenSSH\ssh.exe'

# 7) Aliases personalizados
Set-Alias vim   nvim
Set-Alias ll    ls
Set-Alias g     git
Set-Alias grep  findstr
Set-Alias tig   'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less  'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias hk    heroku
Set-Alias c     z

# 8) Funciones de utilidad
function which($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
      Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

