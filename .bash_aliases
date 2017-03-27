#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    .shaliases                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mc </var/spool/mail/mc>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2017/01/26 20:50:04 by mc                #+#    #+#              #
#    Updated: 2017/03/27 09:03:32 by mc               ###   ########.fr        #
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
alias del='~/sh_script/trash.sh'
alias zconf='e ~/.zshrc'
alias bconf='e ~/.bashrc'
alias econf='e ~/.emacs.d/init.el'
# alias e='sh ~/sh_script/tab_emacs.sh'
alias e="$EDITOR"
alias v="$VISUAL"
alias t='sh ~/sh_script/rename_tab.sh'
alias gdb="gdb -quiet"
alias sql="mysql -u root -p --silent"
alias se="SUDO_EDITOR=\"emacsclient -t -a emacs\" sudoedit"
alias sudo='sudo ' # keep aliases after sudo
alias ocaml='rlwrap ocaml'
alias py='python3'
alias copy='xsel --clipboard'
alias sbcl='sbcl --noinform'
alias now='date "+%y-%m-%d_%H-%M-%S"'
alias cl="rlwrap sbcl"
alias sql="mysql --prompt=\"$(echo -e '\033[32;01m\\d\033[33;01m@\033[31;01m\\h> \033[0m')\" -uroot -p"
# alias die='dbus-send --system --print-reply --dest="org.freedesktop.ConsoleKit"  /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Stop' #debian only
alias open='xdg-open'
eval "$(thefuck --alias fok 2> /dev/null)"

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
    alias pacsearch='pacsearch -c'
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
	# alias diff="colourify diff --color=always"
	alias cat="$GRC -es --colour=on cat"
	alias configure='colourify ./configure'
	alias as="colourify as"
	alias ant="colourify ant"
	alias blkid="colourify blkid"
	alias cc="colourify cc"
	alias cvs="colourify cvs"
	alias df="colourify df"
	alias dig="colourify dig"
	alias dnf="colourify dnf"
	alias docker="colourify docker"
	alias du="colourify du -h"
	alias env="colourify env"
	alias esperanto="colourify esperanto"
	alias free="colourify free"
	alias gas="colourify gas"
	alias g++="colourify g++"
	alias gcc="colourify gcc"
	alias getfacl="colourify getfacl"
	alias gmake="colourify gmake"
	alias head="colourify head"
	alias ifconfig="colourify ifconfig"
	alias iostat="colourify iostat"
	alias ip="colourify ip"
	alias iptables="colourify iptables"
	alias irclog="colourify irclog"
	alias journalctl="colourify journalctl"
	alias last="colourify last"
	alias ld="colourify ld"
	alias ldap="colourify ldap"
	alias link="colourify link"
	alias log="colourify log"
	alias lsattr="colourify lsattr"
	alias lsblk="colourify lsblk"
	alias lsmod="colourify lsmod"
	alias lspci="colourify lspci"
	alias make="colourify make"
	alias mount="colourify mount"
	alias mtr="colourify mtr"
	alias mvn="colourify mvn"
	alias netstat="colourify netstat"
	alias nmap="colourify nmap"
	alias php="colourify php"
	alias ping="colourify ping"
	alias ping6="colourify ping6"
	alias proftpd="colourify proftpd"
	alias ps="colourify ps"
	alias pv="colourify pv"
	alias sar="colourify sar"
	alias semanage="colourify semanage"
	alias showmount="colourify showmount"
	alias sql="colourify sql"
	alias ss="colourify ss"
	alias stat="colourify stat"
	alias sysctl="colourify sysctl"
	alias systemctl="colourify systemctl"
	alias tail="colourify tail"
	alias tcpdump="colourify tcpdump"
	alias traceroute="colourify traceroute"
	alias traceroute6="colourify traceroute6"
	alias tune2fs="colourify tune2fs"
	alias ulimit="colourify ulimit"
	alias uptime="colourify uptime"
	alias vmstat="colourify vmstat"
	alias w="colourify w"
	alias wdiff="colourify wdiff"
	alias who="colourify who"
fi


# added from terminal
