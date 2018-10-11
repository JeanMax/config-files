#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    .bash_aliases                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mc </var/spool/mail/mc>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2017/01/26 20:50:04 by mc                #+#    #+#              #
#    Updated: 2018/10/10 15:36:00 by mc               ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# functions are way better than aliases actually!  (actually bis: not really?)
man_emacs() {
    emacsclient -t --eval "(progn (man \"$1\") (other-window 1) (delete-other-windows))"
}

# misc aliases
alias l='ls'
alias ll='ls -lh'
alias la='ls -lAh'
alias norm='norminette --CheckForbiddenSourceHeader'
alias normall='norminette --CheckForbiddenSourceHeader **/*.[ch]'
alias gccf='gcc -std=c11 -Wall -Wextra -Werror'
alias now='date "+%y-%m-%d_%H-%M-%S"'
alias ext-ip='curl -s http://ipecho.net/plain; echo;'
alias led='ledger --no-pager --force-color --color -f ~/kraken.ledger --price-db ~/kraken.price-db'
alias pi='ipython --no-confirm-exit --no-banner'
alias py='python3'
alias copy='xsel --clipboard'
alias caml='rlwrap ocaml'
alias cl='rlwrap sbcl --noinform'
alias open='xdg-open'
alias t='sh ~/sh_script/rename_tab.sh'  # TODO: write fun instead
alias del='~/sh_script/trash.sh'  # TODO: write fun instead
# SQL_ARGS="--prompt=\"$(echo -e '\033[32;01m\\d\033[33;01m@\033[31;01m\\h> \033[0m')\" -uroot -p --silent"
SQL_ARGS="--silent --prompt=\"$(echo -e '\\d@\\h> \033[0m')\" -u genesys -p"
alias sql="mysql $SQL_ARGS"
alias emount="~/sh_script/crypt.sh mount"
alias eumount="~/sh_script/crypt.sh umount"


# emacs stuffs
alias e="$EDITOR"
alias em='emacs --no-window-system --no-x-resources --no-splash'
alias v="$VISUAL"
alias se="SUDO_EDITOR=\"emacsclient -t -a emacs\" sudoedit"
alias man='man_emacs'
alias mail='em --eval "(gnu)"'

# flash conf edit
alias zconf='e ~/.zshrc'
alias bconf='e ~/.bashrc'
alias aconf='e ~/.bash_aliases && . ~/.bash_aliases'
alias econf='e ~/.emacs.d/init.el'

# git aliases
alias ga='git add -A'
alias gb='PAGER= git branch'
alias gbb='git remote show origin'
alias gcm='git commit -m'
alias gce='git commit'
alias gco='git checkout'
alias gpl='git pull --ff-only'
alias gp='git push'
alias gpo='git push origin'
alias gpa='git push --all origin'  #yolo
alias gpom='git push origin master'
alias gm='git merge --verbose --progress --no-ff'
alias gs='git status'
alias gh='git stash'
alias ghl='PAGER= git stash list --decorate'
alias ghs='git stash show'
alias gha='git stash apply'
alias ghm='git stash push -m'
alias ghp='git stash pop'
alias gf="git fetch --verbose --progress --all --prune -j$(nproc 2>/dev/null || echo 1)"
alias gd='git diff'
alias gdc='git diff --cached'
alias gtree='git log --oneline --graph --decorate --branches --remotes --tags --notes'
alias gl='git log --oneline --graph --decorate'
alias gll='git log'
alias gr='git reset'
alias gcl='git clone --recursive'

gpla() {
    # git-pull_all-my-branches

    remote="$(test $1 && echo $1 || echo origin)"
    # log_file=/tmp/git-pull_all-my-branches.log

    git fetch --all --prune
    current_branch=$(git branch | \grep '*' | cut -d' ' -f2)
    branches=$(git remote show "$remote" | \grep 'out of date' | cut -d' ' -f5)

    if test "$branches"; then
        # git add -A .
        # git stash

        # echo "[$(date)]" >> $log_file
        echo

        for branch in $(echo $branches); do
            echo "[$branch] "
            git checkout "$branch"
            git pull --ff-only
            echo
        done # |& tee -a $log_file |& less

        git checkout "$current_branch"
        # git stash apply # pop?
    fi
}

# keep aliases after those
alias sudo='sudo '
alias watch='watch -c -t -n 3 '

# these were kinda hard to do write with a function
eval "$(thefuck --alias fok 2> /dev/null)"
alias gdb='gdb -quiet'
alias c='cd'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'


# yes, I'm human
alias du='du -h'
alias df='df -h'
alias free='free -h'

# typo aliases
alias xs='cd'
alias vf='cd'
alias z=e
alias m=ls
alias k=ls
alias ms=ls
alias lq=ls
alias ks=ls
alias sl=ls
alias pyhton=python
alias ipyhton=ipython
alias unmount=umount
alias umout=umount


# enable color support
if [ "$(uname -s)" = "Linux" ]; then
    if test -x /usr/bin/dircolors && test -r ~/.dircolors; then
        eval "$(dircolors -b ~/.dircolors)"
    else
        export LS_COLORS="no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;31:tw=40;1;41:ow=40;1;41:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.deb=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.mpg=01;37:*.avi=01;37:*.gl=01;37:*.dl=01;37:"
    fi
    alias ls='ls --color=auto'
else
    export LSCOLORS="ExGxcxdxBxexexaBaBacad"
    alias ls='ls -G'
fi

alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias wdiff='dwdiff -c'
alias pacsearch='pacsearch -c'
alias pactree='pactree -c'
alias bb='bb-wrapper --aur --build-dir /tmp/bb-build'


# support colors in less
export LESS=-R
export LESS_TERMCAP_mb=$(printf "\e[1;31m")
export LESS_TERMCAP_md=$(printf "\e[1;31m")
export LESS_TERMCAP_me=$(printf "\e[0m")
export LESS_TERMCAP_se=$(printf "\e[0m")
export LESS_TERMCAP_so=$(printf "\e[1;44;33m")
export LESS_TERMCAP_ue=$(printf "\e[0m")
export LESS_TERMCAP_us=$(printf "\e[1;32m")


# moar colors
if [ "$TERM" != dumb ] && $(hash grc 2>/dev/null); then
    alias colourify="grc -es --colour=auto"

    if [ $(uname -s) = "Linux" ]; then
        alias ll="colourify ls -lh --color=always"
        alias la="colourify ls -lAh --color=always"
    else
        alias ll="ls -lh"
        alias la="ls -lAh"
    fi
    alias cat="grc -es --colour=on cat"
    alias configure='colourify ./configure'
    alias du="colourify du -h"
    alias df="colourify df -h"
    alias free="colourify free -h"
    alias sql="colourify mysql $SQL_ARGS"
    alias cc="cc -fdiagnostics-color=always"
    alias g++="g++ -fdiagnostics-color=always"
    alias gcc="gcc -fdiagnostics-color=always"

    # bugged, don't use it
    # alias make="$(hash colormake 2>/dev/null && echo colormake || echo colourify make)"

    alias as="colourify as"
    alias blkid="colourify blkid"
    alias dig="colourify dig"
    alias env="colourify env"
    alias getfacl="colourify getfacl"
    alias head="colourify head"
    alias ifconfig="colourify ifconfig"
    alias iostat="colourify iostat"
    alias ip="colourify ip"
    alias iptables="colourify iptables"
    alias journalctl="colourify journalctl"
    alias last="colourify last"
    alias ld="colourify ld"
    alias link="colourify link"
    alias lsattr="colourify lsattr"
    alias lsblk="colourify lsblk"
    alias lsmod="colourify lsmod"
    alias lspci="colourify lspci"
    alias lshw="colourify lshw"
    alias mount="colourify mount"
    alias netstat="colourify netstat"
    alias nmap="colourify nmap"
    alias php="colourify php"
    alias ping="colourify ping"
    alias ps="colourify ps"
    alias sar="colourify sar"
    alias showmount="colourify showmount"
    alias ss="colourify ss"
    alias stat="colourify stat"
    alias sysctl="colourify sysctl"
    alias systemctl="colourify systemctl"
    alias tail="colourify tail"
    alias tcpdump="colourify tcpdump"
    alias traceroute="colourify traceroute"
    alias tune2fs="colourify tune2fs"
    alias uptime="colourify uptime"
    alias vmstat="colourify vmstat"
    alias w="colourify w"
    alias who="colourify who"
    alias lsof="colourify lsof"
    alias docker="colourify docker"
    alias docker-machine="colourify docker-machine"
    alias docker-compose="colourify docker-compose"

    # alias diff="colourify diff --color=always" #clash with diff colors

    # unused
    # alias ant="colourify ant"
    # alias cvs="colourify cvs"
    # alias esperanto="colourify esperanto"
    # alias dnf="colourify dnf"
    # alias gas="colourify gas"
    # alias gmake="colourify gmake"
    # alias irclog="colourify irclog"
    # alias ldap="colourify ldap"
    # alias log="colourify log"
    # alias mtr="colourify mtr"
    # alias mvn="colourify mvn"
    # alias ping6="colourify ping6"
    # alias proftpd="colourify proftpd"
    # alias pv="colourify pv"
    # alias semanage="colourify semanage"
    # alias traceroute6="colourify traceroute6"
    # alias ulimit="colourify ulimit" #bjorked
    # alias wdiff="colourify wdiff"
fi
unset SQL_ARGS
