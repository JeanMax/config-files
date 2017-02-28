# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    .zshrc                                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/01/23 17:38:59 by mcanal            #+#    #+#              #
#    Updated: 2017/01/30 15:18:58 by mc               ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source ~/.bashrc

# Reglage du terminal
if [[ $TERM = dumb ]]; then
    # disable weird escape sequences
    unsetopt zle
else
    echo -ne "\033]0;$USER@$HOST:${PWD/$HOME/~}\007";
    if [[ $TERM != rxvt-256color ]]; then
        TERM=xterm-256color
        # Correction de la touche Delete / ctrl-left / ctrl-right
        bindkey "\e[3~"   delete-char
        bindkey "\e[1;5D" backward-word
        bindkey "\e[1;5C" forward-word
        bindkey "\e[3;5~" kill-word
    else
        bindkey "\e[3~"   delete-char
        bindkey "^[Od" backward-word
        bindkey "^[Oc" forward-word
        bindkey "\e[3;5~" kill-word
        # bindkey "\e[3^" kill-word
    fi
fi

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
#setopt EXTENDED_HISTORY

# report the status of backgrounds jobs immediately
setopt notify

# Autocompletion de type menu
autoload -Uz compinit promptinit && compinit && promptinit
zstyle ':completion:*' menu select
# setopt COMPLETE_ALIASES

# Use modern completion system
#autoload -Uz compinit
#compinit
#zstyle ':completion:*' auto-description 'specify: %d'
#zstyle ':completion:*' completer _expand _complete _correct _approximate
#zstyle ':completion:*' format 'Completing %d'
#zstyle ':completion:*' group-name ''
#zstyle ':completion:*' menu select=2
#eval "$(dircolors -b)"
#zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*' list-colors ''
#zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
#zstyle ':completion:*' menu select=long
#zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
#zstyle ':completion:*' use-compctl false
#zstyle ':completion:*' verbose true
zstyle ':completion:*' rehash true #refresh $PATH commands
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh.d/cache

#Fuzzy matching:
# zstyle ':completion:*' completer _complete _match _approximate
# zstyle ':completion:*:match:*' original only
# zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Don't send SIGHUP to background processes when the shell exits.
# setopt nohup

# avoid "beep"ing
setopt nobeep

# correct typo
unsetopt correct_all  # correct only command
setopt correct

# des couleurs pour la complétion
zmodload zsh/complist
setopt extendedglob


# Couleur prompt
autoload -U colors && colors

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# zsh-syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh autosuggestion
# source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
