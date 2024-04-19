#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    .bash_aliases                                      :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mc </var/spool/mail/mc>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2017/01/26 20:50:04 by mc                #+#    #+#              #
#    Updated: 2020/06/03 13:03:19 by mc               ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# functions are way better than aliases actually!  (actually bis: not really?)
# TODO: add fun showing fun/alias source (alias X || type X, but with zsh compat)
man_emacs() {
    emacsclient -t --eval "(progn (man \"$1\") (other-window 1) (delete-other-windows))"
}

sizeof() {
    find "${1:-$PWD}" -maxdepth 1 -print0 \
        | du -ah -d1 --files0-from - \
        | sort -h
}

prev() {
    fd --print0 $@ \
        | fzf --read0 --preview '{bat --color=always {} || tree -C {}} 2>/dev/null | head -500'
}

vm() {
    target=${1:-arch}
    sudo systemd-nspawn --boot --ephemeral --directory "/var/lib/machines/$target"
}


bob() {
    python -c '
import sys
args = sys.argv[1:] if sys.stdin.isatty() else sys.stdin
for s in args:
  print(
    "".join(
      [s[i:i+2].capitalize() for i in range(0, len(s), 2)]
    ).rstrip()
  )
' "${@:1}"
}


alias tree="tree -I '__pycache__|.git' --sort version --dirsfirst"

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
alias sz="sizeof"
alias lsblk="lsblk -o NAME,LABEL,SIZE,FSAVAIL,FSUSE%,MOUNTPOINT,UUID"

iperl() {
    rlwrap -A -pgreen -S"perl> " perl -wnE'say eval()//$@'
}

# emacs stuffs
alias e="$EDITOR"
alias em='emacs --no-window-system --no-x-resources --no-splash'
alias v="$VISUAL"
alias se="SUDO_EDITOR=\"emacsclient -t -a emacs\" sudoedit"
alias man='man_emacs'
alias mail='em --eval "(progn (sleep-for 0.1) (gnu))"'

# flash conf edit
alias zconf='e ~/.zshrc'
alias bconf='e ~/.bashrc'
alias aconf='e ~/.bash_aliases && . ~/.bash_aliases'
alias econf='e ~/.emacs.d/init.el'
alias iconf='e ~/.config/i3/config'

# git aliases
alias gsub='git submodule sync && git submodule update --init --recursive'
alias ga='git add -A'
alias gb='PAGER= git branch'
alias gbb='git remote show origin'
gcm() { git commit -m "$@" && git-974; }
gcf() { git commit --fixup "$@" && git-974; }
alias gce='git commit && git-974'
alias gco='git checkout'
alias gplf='git pull'
alias gpl='git pull --ff-only'
alias gplo='git pull --ff-only origin'
alias gplom='git pull --ff-only origin master'
alias gp='git push'
alias gpo='git push origin'
# alias gpa='git push --all origin'  #yolo
alias gpom='git push origin master'
alias gpf='git push --force-with-lease'
alias gm='git merge --verbose --progress --no-ff'
alias gs='git status'
alias gh='git stash'
alias ghl='PAGER= git stash list --decorate'
alias ghs='git stash show'
alias ghd='git stash show -p'
alias gha='git stash apply'
alias ghm='git stash push -m'
alias ghp='git stash pop'
alias gf="git fetch --verbose --progress --all --prune -j$(nproc 2>/dev/null || echo 1)"
alias gd='git diff'
alias gdc='git diff --cached'
alias gds='PAGER= git diff --stat'
alias gdcs='PAGER= git diff --cached --stat'
alias gtree='git log --oneline --graph --decorate --branches --remotes --tags --notes'
alias gl='git log --oneline --graph --decorate'
alias gll='git log'
alias gr='git reset'
alias gcl='git clone --recursive'
alias git-splootch="git commit --amend --reuse-message=HEAD && git-974"
alias poule="~/sh_script/poule.sh"
alias grb="git rebase"
alias grbi="git rebase --autosquash -i master"
alias grbm="git rebase master"
alias gref="git reflog"
# alias grbm="git checkout master && git pull && git checkout - && git rebase master"
alias gw="git worktree"
alias gwl="git worktree list"

gwa() {
    local ref=$(gbex "$1" || echo "$1")
    local dst="$HOME/aggron-worktrees/$ref"
    echo "Adding $dst ..."
    git worktree add "$dst" "$ref" \
        || git worktree add -b "$ref" "$dst"
    cd "$dst"
    # rsync -harz --exclude .git ~/aggron/external/ external
    # for f in $(find external -name .git); do
    #     sed -i -E "s|../../.git|../../../../aggron/.git/worktrees/$ref|" "$f"
    # done
    gsub
    gwl
}

gwrm() {
    local ref=$(gbex "$1" || echo "$1")
    echo "Removing $ref ..."
    cd ~/aggron
    git worktree remove -f "$ref"
    gwl
}

gbex() {
    git rev-parse --abbrev-ref --all \
        | sed -E 's|^origin/||g' \
        | sort | uniq \
        | grep -Em1 "$@"
}

gcoo() {
    git checkout "$(gbex "$@")"
}

gcp() {
    git commit -m "$(git log --oneline | head -n1 | cut -d' ' -f2-)" -e
}

gpla() {
    # git-pull_all-my-branches

    remote="$(test $1 && echo $1 || git remote show)"
    remote_show="$(git remote show "$remote")"

    branches=$(echo "$remote_show" | grep 'out of date' | cut -d' ' -f5)

    local_branches=$(echo "$remote_show" \
                         | grep -B 1000 'Local branches' \
                         | tail -n +6 \
                         | head -n -1 \
                         | cut -d' ' -f5)
    push_branches=$(echo "$remote_show" \
                        | grep -A 1000 'Local refs' \
                        | tail -n +2 \
                        | cut -d' ' -f5)
    diff=$(diff <(echo "$local_branches") <(echo "$push_branches"))
    if test "$diff"; then
        diff_branches=$(echo "$diff" | grep -E '^<' | cut -d' ' -f2)
        branches=$(echo "$diff_branches
$branches" | sort | uniq)
    fi

    if test "$branches"; then
		current_branch=$(git branch | grep '*' | cut -d' ' -f2)
        # git add -A .
        # git stash

		git fetch --all --prune
        echo
        for branch in $(echo $branches); do
            echo "[$branch] "
            git checkout "$branch"
			git merge --ff-only "$remote/$branch"
            echo
        done

        git checkout "$current_branch"
        # git stash apply # pop?
    fi
}

git-974() {
    local short commits rand_bytes
    short=$(git rev-parse --short HEAD)
    commits=$(git log --branches --remotes --pretty=format:"%h")
    while true; do
        rand_bytes=$(head -c2 /dev/urandom | xxd -p | head -c3)
        gitc0ffee --update-ref --prefix 974"$rand_bytes"
        short=$(git rev-parse --short HEAD)
        grep -q "$short" <<< "$commits" || break
    done
}


# keep aliases after those
alias sudo='sudo '
alias watch='watch -c -t -n 3 '

# these were kinda hard to write with a function
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
alias grep='grep --color=auto -I --exclude-dir .git'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
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
# LESSOPEN="|/usr/bin/lesspipe.sh %s"

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
    # alias cat="grc -es --colour=on cat"
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
    alias lsblk="colourify lsblk -o NAME,LABEL,SIZE,FSAVAIL,FSUSE%,MOUNTPOINT,UUID"
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
    alias wdiff="colourify wdiff"

    colored_sizeof() {
        sizeof "$1" | grcat /usr/share/grc/conf.du
    }
    alias sizeof="colored_sizeof"

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


alias pc='gpg -d ~/.pass.gpg 2>/dev/null | xsel --clipboard && {sleep 60; xsel --clipboard --delete} &'
