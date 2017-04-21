#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    .shaliases                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mc </var/spool/mail/mc>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2017/01/26 20:50:04 by mc                #+#    #+#              #
#    Updated: 2017/04/18 13:41:46 by mc               ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


# general aliases
alias norm='norminette --CheckForbiddenSourceHeader'
alias normall='norminette --CheckForbiddenSourceHeader **/*.[ch]'
alias gccf='gcc -std=c11 -Wall -Wextra -Werror'
alias l='ls'
alias c='cd'
alias ll='ls -lh'
alias la='ls -lAh'
alias du='du -h'
alias df='df -h'
alias free='free -h'
alias del='~/sh_script/trash.sh'
alias zconf='e ~/.zshrc'
alias bconf='e ~/.bashrc'
alias econf='e ~/.emacs.d/init.el'
alias e="$EDITOR"
alias v="$VISUAL"
alias t='sh ~/sh_script/rename_tab.sh'
alias gdb="gdb -quiet"
alias se="SUDO_EDITOR=\"emacsclient -t -a emacs\" sudoedit"
alias sudo='sudo ' # keep aliases after sudo
alias ocaml='rlwrap ocaml'
alias py='python3'
alias copy='xsel --clipboard'
alias sbcl='sbcl --noinform'
alias now='date "+%y-%m-%d_%H-%M-%S"'
alias ext-ip='curl -s http://ipecho.net/plain ; echo;'
alias cl="rlwrap sbcl"
# alias die='dbus-send --system --print-reply --dest="org.freedesktop.ConsoleKit"  /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Stop' #debian only
alias open='xdg-open'
eval "$(thefuck --alias fok 2> /dev/null)"
SQL_ARGS="--prompt=\"$(echo -e '\033[32;01m\\d\033[33;01m@\033[31;01m\\h> \033[0m')\" -uroot -p --silent"
alias sql="mysql $SQL_ARGS"

function man_emacs() {
	emacsclient -t --eval "(progn (man \"$1\") (other-window 1) (delete-other-windows))"
}
alias man='man_emacs'

# alias .='echo $PWD'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
# alias /='cd /'

# git aliases
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


# typo aliases
alias xs='cd'
alias vf='cd'
alias z='e'
alias m='ls'
alias k='ls'
alias ms='ls'
alias lq='ls'
alias ks='ls'
alias sl='ls'


# enable color support
if [ -x /usr/bin/dircolors ]; then
	if [ $(uname -s) = "Linux" ]; then
		test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || export LS_COLORS="no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;31:tw=40;1;41:ow=40;1;41:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.deb=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.mpg=01;37:*.avi=01;37:*.gl=01;37:*.dl=01;37:"
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
fi


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
GRC="$(which grc)"
if [ "$TERM" != dumb ] && [ -n "$GRC" ]; then
    alias colourify="$GRC -es --colour=auto"

	alias ll="colourify \ls -lh --color=always"
	alias la="colourify \ls -lAh --color=always"
	alias cat="$GRC -es --colour=on cat"
	alias configure='colourify ./configure'
	alias du="colourify du -h"
	alias df="colourify df -h"
	alias free="colourify free -h"
	alias sql="colourify mysql $SQL_ARGS"
	alias cc="cc -fdiagnostics-color=always"
	alias g++="g++ -fdiagnostics-color=always"
	alias gcc="gcc -fdiagnostics-color=always"
	# alias make=$(hash colormake && echo "colormake" || echo "colourify make")

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

	# alias diff="colourify diff --color=always" #clash with diff colors

	# unused
	# alias ant="colourify ant"
	# alias cvs="colourify cvs"
	# alias docker="colourify docker"
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
	# alias ulimit="colourify ulimit" #björked
	# alias wdiff="colourify wdiff"
fi
unset SQL_ARGS

# added from terminal
