#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias dotfiles='/usr/bin/git --git-dir=/home/dmitry/.dotfiles/ --work-tree=/home/dmitry'

export PATH="~/.local/bin:$PATH"
