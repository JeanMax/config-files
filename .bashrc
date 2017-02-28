# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    .bashrc                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mc </var/spool/mail/mc>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2017/01/26 20:39:01 by mc                #+#    #+#              #
#    Updated: 2017/01/31 14:56:19 by mc               ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#
# this file will aslo be sourced in ~/.zshrc, so we'll try to keep it compatible
# with zsh
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# default editor
export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -t"
# export VISUAL="emacsclient -c" # it's kinda annoying


#mail TODO: move these in another file
export MAIL="mc.maxcanal@gmail.com"
export EMAIL="$MAIL"
export NAME="Max Canal"
export SMTPSERVER="smtp.gmail.com"

#clang debuging stuff
ASAN_SYMBOLIZER_PATH=$(which llvm-symbolizer)
export ASAN_SYMBOLIZER_PATH

# Big boys use big history
HISTSIZE=2000
SAVEHIST=1500
HISTFILE=~/.zsh_history

# stty -ixon #forward search with ^s

export TRASH=$(test $(uname -s) = "Linux" && echo "$HOME/.local/share/Trash/files" || echo "$HOME/.Trash")

# locales
# export LANG=en_US.UTF-8
# export LANGUAGE=en_US.UTF-8
# export LC_CTYPE=en_US.UTF-8
# export LC_NUMERIC=fr_FR.UTF-8
# export LC_TIME=fr_FR.UTF-8
# export LC_COLLATE=en_US.UTF-8
# export LC_MONETARY=fr_FR.UTF-8
# export LC_MESSAGES=en_US.UTF-8
# export LC_PAPER=fr_FR.UTF-8
# export LC_NAME=fr_FR.UTF-8
# export LC_ADDRESS=fr_FR.UTF-8
# export LC_TELEPHONE=fr_FR.UTF-8
# export LC_MEASUREMENT=fr_FR.UTF-8
# export LC_IDENTIFICATION=fr_FR.UTF-8
# export LC_ALL=en_US.UTF-8

export PATH="$HOME/.roswell/bin:$PATH"
# report about cpu-/system-/user-time of command if running longer than
# 5 seconds
REPORTTIME=5


NORMAL="%{$reset_color%}"

# Definition du prompt
precmd ()
{
    if [ $? -eq 0 ]
    then
        COLOR3="%{$fg[green]%}"
    else
        COLOR3="%{$fg[red]%}"
    fi
    ISGIT=$(git status 2> /dev/null)
    if [ -n "$ISGIT" ]
    then
        STATUS=$(echo "$ISGIT" | grep "modifié:\|:\|nouveau fichier:\|supprimé:")
        BRANCH=$(git branch | cut -d ' ' -f 2 | tr -d '\n')
        if [ -n "$STATUS" ]
        then
            COLOR="%{$fg[red]%}"
        else
            REMOTE_EXIST=$(git branch -a | grep remotes/origin/$BRANCH)
            if [ -n "$REMOTE_EXIST" ]
            then
                REMOTE=$(git diff origin/$BRANCH $BRANCH)
                if [ -n "$REMOTE" ]
                then
                    COLOR="%{$fg[yellow]%}"
                else
                    COLOR="%{$fg[green]%}"
                fi
            else
                COLOR="%{$fg[green]%}"
            fi
        fi
        RPROMPT="%{$COLOR%}($BRANCH)%{$NORMAL%}"
    else
        RPROMPT=""
    fi
    RPROMPT="$RPROMPT"
    PROMPT="%B%{$fg[green]%}%n@%{$fg[yellow]%}%m%{$NORMAL%}%B:%{$fg[red]%}%~%{$NORMAL%}
%B%{$COLOR3%}> %{$NORMAL%}%b"

}


# Couleurs pour le man
man()
{
    env \
        LESS_TERMCAP_mb=$(printf "\e[1;31m") \
        LESS_TERMCAP_md=$(printf "\e[1;31m") \
        LESS_TERMCAP_me=$(printf "\e[0m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_ue=$(printf "\e[0m") \
        LESS_TERMCAP_us=$(printf "\e[1;32m") \
        man "$@"
}

# support colors in less
export LESS=-R
export LESS_TERMCAP_mb=$(printf "\e[1;31m")
export LESS_TERMCAP_md=$(printf "\e[1;31m")
export LESS_TERMCAP_me=$(printf "\e[0m")
export LESS_TERMCAP_se=$(printf "\e[0m")
export LESS_TERMCAP_so=$(printf "\e[1;44;33m")
export LESS_TERMCAP_ue=$(printf "\e[0m")
export LESS_TERMCAP_us=$(printf "\e[1;32m")

if [ $(uname -s) = "Linux" ]; then
    # export LS_COLORS="no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;31:tw=40;1;41:ow=40;1;41:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.deb=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.mpg=01;37:*.avi=01;37:*.gl=01;37:*.dl=01;37:"

    export LS_COLORS="no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;31:tw=40;1;41:ow=40;1;41:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.deb=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.mpg=01;37:*.avi=01;37:*.gl=01;37:*.dl=01;37:"
    alias ls='ls --color=auto'
else
    export LSCOLORS="ExGxcxdxBxexexaBaBacad"
    alias ls='ls -G'

    export PATH="$HOME/.brew/bin:$PATH"
fi

source ~/.bash_aliases
