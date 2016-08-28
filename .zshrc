# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    .zshrc                                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/01/23 17:38:59 by mcanal            #+#    #+#              #
#    Updated: 2016/08/28 02:40:37 by mcanal           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# default editor
export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -t"

#ocaml shit
. /home/mcanal/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# Reglage du terminal
if [[ $TERM = dumb ]]; then
    # disable weird escape sequences
    unsetopt zle
else
    TERM=xterm-256color
    echo -n "\033]0;$PWD\007";
fi


#mail
export EMAIL="mc.maxcanal@gmail.com"
export NAME="Max Canal"
export SMTPSERVER="smtp.gmail.com"

#clang debuging stuff
ASAN_SYMBOLIZER_PATH=$(which llvm-symbolizer-3.6)
export ASAN_SYMBOLIZER_PATH

# Big boys use big history
HISTSIZE=2000
SAVEHIST=1500
HISTFILE=~/.zsh_history
setopt APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
stty -ixon #forward search with ^s
#setopt EXTENDED_HISTORY

export TRASH=$(test $(uname -s) = "Linux" && echo ~/.local/share/Trash/files || echo ~/.Trash)

# Correction de la touche Delete / ctrl-left / ctrl-right
bindkey "\e[3~"   delete-char
bindkey "\e[1;5D" backward-word
bindkey "\e[1;5C" forward-word
bindkey "\e[3;5~" kill-word

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
  or=40;31;01:ex=01;31:tw=40;1;41:ow=40;1;41:*.tar=01;31:*.tgz=01;31:\ 
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
    PROMPT="%B%{$fg[green]%}%n@%{$fg[yellow]%}%m%{$NORMAL%}%B:%{$fg[red]%}%~%{$NORMAL%}
%B%{$COLOR3%}> %{$NORMAL%}%b"

}

# enable color support of ls and also add handy aliases 
#if [ -x /usr/bin/dircolors ]; then
#    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
#fi

export LS_COLORS="no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;31:tw=40;1;41:ow=40;1;41:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.deb=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.mpg=01;37:*.avi=01;37:*.gl=01;37:*.dl=01;37:"

# Definition des alias de git
alias gg="sh ~/sh_script/git.sh"
alias ga="git add -A"
alias gb="git branch"
alias gcm="git commit -m"
alias gco="git checkout"
alias gpl="git pull"
alias gp="git push"
alias gpom="git push origin master"
alias gm="git merge"
alias gu="git add -u"
alias gl="git log"

# Definition des alias
alias lxterminal='lxterminal --geometry=81x45'
alias norm='norminette --CheckForbiddenSourceHeader'
alias normall='norminette --CheckForbiddenSourceHeader **/*.[ch]'
alias gcc='gcc -std=c11'
alias gccf='gcc -std=c11 -Wall -Wextra -Werror'
alias gcc99='gcc -std=c99 -Wall -Wextra -Werror'
alias pp='clang++ -Wall -Werror -Wextra -Wpedantic -O2'
alias l='ls'
alias ll='ls -l'
alias la='ls -lA'
alias lah='ls -lAh'
alias lh='ls -lh'
#alias ls='ls -G'
alias usb='cd /media/mcanal/Lexar/'
alias del='~/sh_script/trash.sh'
alias zconf='e ~/.zshrc'
alias econf='e ~/.emacs'
# alias e='sh ~/sh_script/tab_emacs.sh'
alias e="$EDITOR"
alias cd='. ~/sh_script/tab_cd.sh'
alias t='sh ~/sh_script/rename_tab.sh'
alias re="make re;"
alias gdb="gdb -quiet"
alias sql="mysql -u root -p --silent"
alias se="SUDO_EDITOR=\"emacsclient -t -a emacs\" sudoedit"
alias loc="sh ~/sh_script/loc.sh"
alias ht='cd /var/www/html/'
alias ap='cd /var/www/html/fuel/app/'
alias ocaml='rlwrap ocaml'
alias py='python3'
alias copy='xsel --clipboard'
alias con='sudo php app/console'
alias cs='sudo php-cs-fixer -vvv --level=symfony fix'
alias sbcl='sbcl --noinform'
alias cl='sbcl'

# typo alias
alias xs='cd'
alias vf='cd'
alias z='e'
alias m='ls'
alias k='ls'
alias ms='ls'
alias lq='ls'
alias ks='ls'
alias sl='ls'

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