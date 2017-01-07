# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    .zshrc                                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/01/23 17:38:59 by mcanal            #+#    #+#              #
#    Updated: 2017/01/05 15:00:25 by mcanal           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# default editor
export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -t"

# Reglage du terminal
if [[ $TERM = dumb ]]; then
    # disable weird escape sequences
    unsetopt zle
else
    TERM=xterm-256color
    echo -n "\033]0;$PWD\007";
fi

#mail TODO: move these in another file
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

export LS_COLORS="no=00:fi=00:di=01;34:ln=01;36:\
  pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:\
  or=40;31;01:ex=01;31:tw=40;1;41:ow=40;1;41:*.tar=01;31:*.tgz=01;31:\
  *.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:\
  *.z=01;31:*.Z=01;31:*.gz=01;31:*.deb=01;31:\
  *.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.ppm=01;35:\
  *.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:\
  *.mpg=01;37:*.avi=01;37:*.gl=01;37:*.dl=01;37:"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Couleur prompt
autoload -U colors && colors

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


if [ $(uname -s) = "Linux" ]; then
    export LS_COLORS="no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;31:tw=40;1;41:ow=40;1;41:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.deb=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.mpg=01;37:*.avi=01;37:*.gl=01;37:*.dl=01;37:"
    alias ls='ls --color=auto'
else
    export LSCOLORS="ExGxcxdxBxexexaBaBacad"
    alias ls='ls -G'
    export PATH="$HOME/.brew/bin:$PATH"
fi

# enable color support of ls and also add handy aliases
#if [ -x /usr/bin/dircolors ]; then
#    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
#fi


# Definition des alias de git
alias ga="git add -A"
alias gb="git branch"
alias gcm="git commit -m"
alias gce="git commit"
alias gco="git checkout"
alias gpl="git pull"
alias gp="git push"
alias gpo="git push origin"
alias gpom="git push origin master"
alias gm="git merge --no-ff"
alias gu="git add -u"
alias gl="git log"
alias gs="git status"
alias gh="git stash"
alias gf="git fetch"
alias gd="git diff"
alias gdc="git diff --cached"
alias gtree="git log --oneline --graph --all --decorate"
alias gr="git reset"

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
alias la='ls -lAh'
alias del='~/sh_script/trash.sh'
alias zconf='e ~/.zshrc'
alias econf='e ~/.emacs.d/init.el'
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
alias com='sudo php -n -d extension=curl.so -d extension=gd.so -d extension=intl.so -d extension=json.so -d extension=mcrypt.so -d extension=mysqli.so -d extension=mysql.so -d extension=pdo.so -d extension=readline.so -d extension=pdo_mysql.so /usr/local/bin/composer'
alias cs='sudo php-cs-fixer -vvv --level=symfony fix'
alias sbcl='sbcl --noinform'
alias now='date "+%y-%m-%d_%H-%M-%S"'
alias cl="rlwrap sbcl"
alias sql="mysql --prompt=\"$(echo -e '\033[32;01m\\d\033[33;01m@\033[31;01m\\h> \033[0m')\" -uroot -p"
export PATH="$HOME/.roswell/bin:$PATH"
alias die='dbus-send --system --print-reply --dest="org.freedesktop.ConsoleKit"  /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Stop'
eval "$(thefuck --alias fok 2> /dev/null)"

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

# locales
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_NUMERIC=fr_FR.UTF-8
export LC_TIME=fr_FR.UTF-8
export LC_COLLATE=en_US.UTF-8
export LC_MONETARY=fr_FR.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_PAPER=fr_FR.UTF-8
export LC_NAME=fr_FR.UTF-8
export LC_ADDRESS=fr_FR.UTF-8
export LC_TELEPHONE=fr_FR.UTF-8
export LC_MEASUREMENT=fr_FR.UTF-8
export LC_IDENTIFICATION=fr_FR.UTF-8
export LC_ALL=en_US.UTF-8
