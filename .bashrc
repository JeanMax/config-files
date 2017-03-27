# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    .bashrc                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mc </var/spool/mail/mc>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2017/01/26 20:39:01 by mc                #+#    #+#              #
#    Updated: 2017/03/27 04:09:36 by mc               ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#
# this file will aslo be sourced in ~/.zshrc, so we'll try to keep it compatible
# with zsh
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Definition du prompt
function get_branch() {
	branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
	test $branch && echo $branch || echo $HOSTNAME
}
P_LOCATION='`pwd | sed "s#\(/[^/]\{1,\}/[^/]\{1,\}/[^/]\{1,\}/\).*\(/[^/]\{1,\}/[^/]\{1,\}\)/\{0,1\}#\1_\2#g"`'
P_BRANCH='$(get_branch)'
PS1="$USER@$P_BRANCH:$P_LOCATION\n\$ "


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

stty -ixon #forward search with ^s (disable interupt)

if [ $(uname -s) = "Linux" ]; then
	export TRASH="$HOME/.local/share/Trash/files"
else
	export TRASH="$HOME/.Trash"
	export PATH="$HOME/.brew/bin:$PATH"
fi
export PATH="$HOME/.roswell/bin:$PATH"

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

# report about cpu-/system-/user-time of command if running longer than
# 5 seconds
REPORTTIME=5

source ~/.bash_aliases
