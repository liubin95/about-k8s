yum install -y zsh
chsh -s /bin/zsh
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

cat <<EOF |  tee ~/.zshrc
source ~/.zplug/init.zsh

# History config
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# zplug plugins
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/extract", from:oh-my-zsh
zplug "plugins/vscode", from:oh-my-zsh
zplug "plugins/dirhistory", from:oh-my-zsh
zplug "plugins/z", from:oh-my-zsh
zplug "plugins/sudo", from:oh-my-zsh
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug 'themes/sorin', from:oh-my-zsh, nice:11

# Install packages that have not been installed yet
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    else
        echo
    fi
fi
zplug load

source <(kubectl completion zsh)

alias lla='ll -a'
EOF

source ~/.zshrc
