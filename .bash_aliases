#!/bin/bash
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    .shaliases                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mc </var/spool/mail/mc>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2017/01/26 20:50:04 by mc                #+#    #+#              #
#    Updated: 2017/01/31 15:33:49 by mc               ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


# general aliases
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
alias bconf='e ~/.bashrc'
alias econf='e ~/.emacs.d/init.el'
# alias e='sh ~/sh_script/tab_emacs.sh'
alias e="$EDITOR"
alias cd='. ~/sh_script/tab_cd.sh'
alias t='sh ~/sh_script/rename_tab.sh'
alias re="make re;"
alias gdb="gdb -quiet"
alias sql="mysql -u root -p --silent"
alias se="SUDO_EDITOR=\"emacsclient -t -a emacs\" sudoedit"
alias sudo='sudo ' # keep aliases after sudo
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
# alias die='dbus-send --system --print-reply --dest="org.freedesktop.ConsoleKit"  /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Stop' #debian only
alias open='xdg-open'
eval "$(thefuck --alias fok 2> /dev/null)"


# enable color support of ls and also add handy aliases
#if [ -x /usr/bin/dircolors ]; then
#    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
#fi


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


# added from terminal
