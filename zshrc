HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

setopt appendhistory autocd extendedglob nomatch notify

# keybindings
bindkey -e
bindkey \^U backward-kill-line

zstyle :compinstall filename '/home/jahl/.zshrc'

autoload -Uz compinit select-word-style promptinit
compinit
select-word-style bash
promptinit
prompt adam1

eval "$(rbenv init -)"

