# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    .bashrc                                            :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mc </var/spool/mail/mc>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2017/01/26 20:39:01 by mc                #+#    #+#              #
#    Updated: 2019/07/15 12:03:49 by mc               ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#
# this file will aslo be sourced in ~/.zshrc, so we'll try to keep it compatible
# with zsh
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# colors
export CLR_BLACK="$(tput setaf 0)"
export CLR_RED="$(tput setaf 1)"
export CLR_GREEN="$(tput setaf 2)"
export CLR_YELLOW="$(tput setaf 3)"
export CLR_BLUE="$(tput setaf 4)"
export CLR_MAGENTA="$(tput setaf 5)"
export CLR_CYAN="$(tput setaf 6)"
export CLR_WHITE="$(tput setaf 7)"

# nb: 2nd set of colors doesn't work if bold
export CLR_BLACK_B="$(tput setaf 8)"
export CLR_RED_B="$(tput setaf 9)"
export CLR_GREEN_B="$(tput setaf 10)"
export CLR_YELLOW_B="$(tput setaf 11)"
export CLR_BLUE_B="$(tput setaf 12)"
export CLR_MAGENTA_B="$(tput setaf 13)"
export CLR_CYAN_B="$(tput setaf 14)"
export CLR_WHITE_B="$(tput setaf 15)"

export CLR_BOLD="$(tput bold)"
export CLR_RESET="$(tput sgr0)"


# prompt
branch() {
    local prev_ret=$?  # preserve previous exit_status
    local status=$(git status 2> /dev/null)
    local branch=$(echo "$status" | head -n1 | grep -Eo '[^ ]+$')
    if test "$status" && test "$branch"; then
        printf "${CLR_RESET}"
        if echo "$status" | grep -q 'working tree clean'; then
            if echo "$status" | grep -q 'branch is ahead'; then
                printf "${CLR_YELLOW}"
            else
                printf "${CLR_GREEN}"
            fi
        else
            printf "${CLR_RED}"
        fi
        printf "  (${branch})"
    fi
    return $prev_ret
}

venv() {
    local prev_ret=$?  # preserve previous exit_status
    if test "$VIRTUAL_ENV"; then
        local venv_name=$(echo "$VIRTUAL_ENV" | sed -E 's|.*/(.*)-.*|\1|')
        if test "$venv_name" = "$VIRTUAL_ENV"; then
            venv_name="$(basename "$(dirname "$VIRTUAL_ENV")")"
        fi
        printf "  [${venv_name}]"
    fi
    return $prev_ret
}

exit_status() {
    test $? == 0 && printf "${CLR_BLUE}" || printf "${CLR_RED}"
}

export VIRTUAL_ENV_DISABLE_PROMPT=t

P_LOCATION='\w'
P_BRANCH='$(branch)'
P_VENV='$(venv)'
P_EXIT_STATUS='$(exit_status)'
PS1="\[${CLR_BOLD}${CLR_BLUE}\]${USER}@\[${CLR_YELLOW}\]${HOSTNAME}\[${CLR_WHITE}\]:\[${CLR_RED}\]${P_LOCATION}${P_BRANCH}\[${CLR_BLUE}\]${P_VENV}\[${CLR_RESET}\]\n\[${CLR_BOLD}${P_EXIT_STATUS}\]>\[${CLR_RESET}\] "




# default editor
export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -t"
# export VISUAL="emacsclient -c" # it's kinda annoying

# cat if less (eheh) than one page
# export LESS="-E -F -X $LESS"


#mail TODO: move these in another file
export MAIL="mc.maxcanal@gmail.com"
export EMAIL="$MAIL"
# export NAME="Max Canal"
export SMTPSERVER="smtp.gmail.com"

#clang debuging stuff
ASAN_SYMBOLIZER_PATH=$(which llvm-symbolizer 2>/dev/null)
export ASAN_SYMBOLIZER_PATH

# Big boys use big history
HISTSIZE=20000
SAVEHIST=15000
HISTFILE=~/.zsh_history

stty -ixon #forward search with ^s (disable interupt)

if [ $(uname -s) = "Linux" ]; then
	export TRASH="$HOME/.local/share/Trash/files"
else
	export TRASH="$HOME/.Trash"
	export PATH="$HOME/.brew/bin:$PATH"
fi

for d in .local/bin go/bin .roswell/bin; do
    test -e "$HOME/$d" && export PATH="$HOME/$d/:$PATH"
done
# if hash ruby 2>/dev/null; then
#    export PATH="$HOME/.gem/ruby/2.6.0/bin:$PATH"
# fi

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

# MAKEFLAGS="-j$(nproc)"
# export MAKEFLAGS

# force qt to use gtk style
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/.gtkrc-2.0"
export QT_STYLE_OVERRIDE=gtk2


# EasyMile stuffs
. $HOME/.cache/pypoetry/virtualenvs/aggron-i_ng7GDs-py3.10/bin/activate
# export PATH="$HOME/aggron/build/simulation/$VEH:$PATH"


export VHC="EZ10-Gen3B-nocoder-SIMU"
export FILTER_VHC="EZ10-Gen3B-nocoder-%"
vhc() {
    local v="$1"
    if test "$v"; then
	    export VHC="$v"
	    export FILTER_VHC=$(sed 's/SIMU\|ECU\|tested\|trusted/%/' <<< "$v")
    else
        unset VHC
	    unset FILTER_VHC
    fi
    env | grep VHC
}


vpn() {
    local action="${1:-list}" \
          nw_name="${2:-EasyMile Global}"
    if test "$action" = list; then
        nmcli c
    else
        nmcli c "$action" "$nw_name" --ask
    fi
}


build() {
    xdg-open https://jenkins.eu.it.easymile.private/job/$(basename $(git rev-parse --show-toplevel))/job/$(git rev-parse --abbrev-ref HEAD | jq -Rr @uri)/build
}


_udp_cmd() {
    local cmd="$1"
    local port="$2"
    local ip="$3"
    if ! test "$ip"; then
        ip=192.168.12.103  # default
    else
        ip=192.168.12.104  # if anything provided
    fi
    nc -u -W1 -w1 "$ip" "$port" <<< "$cmd"
}

version() {
    _udp_cmd version 6007 "$1"
}

panic() {
    _udp_cmd dump-panic 6008 "$1"
}

status() {
    _udp_cmd status 6001 "$1"
}

qual() {
    local cmd="$1"
    local ip="$2"
    if ! test "$ip"; then
        ip=192.168.12.103  # default
    else
        ip=192.168.12.104  # if anything provided
    fi
    if ! test "$cmd"; then
        nc -u "$ip" 7001  # interactive 103
    elif test "$cmd" = 104; then
        nc -u 192.168.12.104 7001  # interactive 104
    else
        printf "$cmd" | nc -u -W1 -w1 "$ip" 7001  # quick
        echo
    fi
}



export AWS_ACCESS_KEY_ID=$(grep aws_access_key_id ~/.aws/credentials \
                                   | cut -d' ' -f3)
export AWS_SECRET_ACCESS_KEY=$(grep aws_secret_access_key ~/.aws/credentials \
                                   | cut -d' ' -f3)
export AWS_DEFAULT_REGION=eu-west-1
export AWS_DEFAULT_OUTPUT=json

source ~/.bash_aliases

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"


#TODO: broken at boot
ssh_agent_cookie=/tmp/.ssh-agent
if ! test -e "$ssh_agent_cookie"; then
    ssh-agent > "$ssh_agent_cookie"
    eval "$(< "$ssh_agent_cookie")"
    ssh-add $(find ~/.ssh -type f | grep -vE '.pub|.old|config|known_hosts')
else
    eval "$(< "$ssh_agent_cookie")" >/dev/null
fi

export LSP_USE_PLISTS=true

if [ "$TERM" != "eterm-color" ]; then
    PS1='\e]7;file://$HOSTNAME$PWD\e\\\\'$PS1
fi
