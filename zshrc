# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    .zshrc                                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/01/23 17:38:59 by mcanal            #+#    #+#              #
#    Updated: 2015/01/26 17:48:26 by mcanal           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# default editor
#EDITOR=/usr/bin/vim
#export EDITOR

# Reglage du terminal
TERM=xterm-256color

# Big boys use big history
HISTSIZE=1200
SAVEHIST=1000
HISTFILE=~/.zsh_history
setopt APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
#setopt EXTENDED_HISTORY

# Correction de la touche Delete
bindkey "\e[3~"   delete-char

# Autocompletion de type menu
autoload -U compinit && compinit
zstyle ':completion:*' menu select

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

# des couleurs pour la complétion
zmodload zsh/complist
setopt extendedglob
export TAB_COLORS="no=00:fi=00:di=01;34:ln=01;36:\ 
  pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:\ 
  or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:\ 
  *.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:\ 
  *.z=01;31:*.Z=01;31:*.gz=01;31:*.deb=01;31:\ 
  *.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.ppm=01;35:\ 
  *.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:\ 
  *.mpg=01;37:*.avi=01;37:*.gl=01;37:*.dl=01;37:"
zstyle ':completion:*' list-colors ${(s.:.)TAB_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Couleur prompt
autoload -U colors && colors

# Definition des couleurs pour ls
# { Répertoires/Liens symboliques/Sockets/Pipes/Exécutables/Blocs spéciaux/
#   Caractères spéciaux/Exécutables(setuid)/Exécutables(setgid)/
#   Répertoires(777 sticky bit)/Répertoires (777 sans le sticky bit)}
# { x défaut x défauta Noir A Noir(gras)b Rouge B Rouge(gras)
#   c Vert C Vert(gras)d Marron D Marron(gras)e Bleu E Bleu(gras)
#   f Violet F Violet(gras)g Cyan GCyan(gras)h Gris H Gris(gras)}
LS=dontdothat
if [ "$LS" = "default" ]; then
	export LSCOLORS="exfxcxdxbxegedabagacad"
elif [ "$LS" = "dontdothat" ]; then
	;
else
	export LSCOLORS="ExfxcxdxbxegedabagacEx"
fi

# git setup
git config --global user.email "mcanal@student.42.fr"
git config --global user.name "JeanMax"

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
    PROMPT="%B%{$fg[green]%}mc@%{$fg[yellow]%}%m%{$NORMAL%}%B:%{$fg[red]%}%~%{$NORMAL%}
%B%{$COLOR3%}> %{$NORMAL%}%b"

}

# enable color support of ls and also add handy aliases 
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircol\
ors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Definition des alias de git
alias ga="git add"
alias gb="git branch"
alias gcm="git commit -m"
alias gco="git checkout"
alias gpl="git pull"
alias gpu="git push"
alias gpom="git push origin master"
alias gm="git merge"
alias gu="git add -u"
alias gl="git log"

# Definition des alias
alias norm='norminette --CheckForbiddenSourceHeader'
alias normall='norminette --CheckForbiddenSourceHeader */*'
alias gcc='gcc -std=c11'
alias gccf='gcc -std=c11 -Wall -Wextra -Werror'
alias gcc99='gcc -std=c99 -Wall -Wextra -Werror'
alias l='ls'
alias ll='ls -l'
alias la='ls -lA'
alias lah='ls -lAh'
alias lh='ls -lh'
#alias ls='ls -G'
alias trash='ls -la ~/.local/share/Trash/files'
alias gotrash='cd ~/.local/share/Trash/files'
alias usb='cd /media/mcanal/Lexar/'
alias del='mv -t ~/.local/share/Trash/files'
alias zconf='e ~/.zshrc'
alias econf='e ~/.emacs'
alias e='emacs22'
alias re="make re;"

# typo alias
alias z='emacs22'
alias xs='cd'
alias vf='cd'
alias ms='ls'
alias lq='ls'

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
