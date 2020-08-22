autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)

setopt COMPLETE_ALIASES

bindkey -M menuselect '^[[Z' reverse-menu-complete
bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'

alias ls='ls --color=auto'

alias dotfiles='/usr/bin/git --git-dir=/home/dmitry/.dotfiles/ --work-tree=/home/dmitry'

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

source $ZDOTDIR/.p10k.zsh

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
