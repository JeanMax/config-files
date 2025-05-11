# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    .zshrc                                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/01/23 17:38:59 by mcanal            #+#    #+#              #
#    you want with this stuff. If we meet some day, and you     |:: '   :|     #
#                                                                              #
# **************************************************************************** #

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source ~/.bashrc

# report about cpu-/system-/user-time of command if running longer than
# 5 seconds
REPORTTIME=5

# Definition du prompt
if false; then #hash starship 2>/dev/null; then
    eval "$(starship init zsh)"
else
precmd ()
{
    if [ $? -eq 0 ]; then
        CMD_COLOR="%{$fg[blue]%}"
    else
        CMD_COLOR="%{$fg[red]%}"
    fi

	GIT_STATUS=$(git status 2> /dev/null)
	if [ -n "$GIT_STATUS" ]; then
		BRANCH=$(echo $GIT_STATUS | head -n1 | grep -Eo '[^ ]+$')
        if echo "$GIT_STATUS" | grep -q 'working tree clean'; then
			if echo "$GIT_STATUS" | grep -q 'branch is ahead'; then
                GIT_COLOR="%{$fg[yellow]%}"
			else
                GIT_COLOR="%{$fg[green]%}"
			fi
		else
			GIT_COLOR="%{$fg[red]%}"
		fi
        RPROMPT="%{$GIT_COLOR%}($BRANCH)%{$reset_color%}"
    else
        RPROMPT=""
	fi

	# ISGIT=$(git status 2> /dev/null)
    # if [ -n "$ISGIT" ]; then
    #     STATUS=$(echo "$ISGIT" | grep "modified:\|:\|new file:\|deleted:")
    #     BRANCH=$(git branch | cut -d ' ' -f 2 | tr -d '\n')
    #     if [ -n "$STATUS" ]; then
    #         GIT_COLOR="%{$fg[red]%}"
    #     else
    #         REMOTE_EXIST=$(git branch -a | grep remotes/origin/$BRANCH)
    #         if [ -n "$REMOTE_EXIST" ]; then
    #             REMOTE=$(git diff origin/$BRANCH $BRANCH)
    #             if [ -n "$REMOTE" ]; then
    #                 GIT_COLOR="%{$fg[yellow]%}"
    #             else
    #                 GIT_COLOR="%{$fg[green]%}"
    #             fi
    #         else
    #             GIT_COLOR="%{$fg[green]%}"
    #         fi
    #     fi
    #     RPROMPT="%{$GIT_COLOR%}($BRANCH)%{$reset_color%}"
    # else
    #     RPROMPT=""
	# fi

	if test $VIRTUAL_ENV; then
		if test $RPROMPT; then
			RPROMPT=" $RPROMPT"
		fi
		PIPENV_NAME=$(echo $VIRTUAL_ENV | sed -E 's|.*/(.*)-.*|\1|')
        if test $PIPENV_NAME = $VIRTUAL_ENV; then
            PIPENV_NAME="$(basename "$(dirname $VIRTUAL_ENV)")"
        fi
		RPROMPT="%{$fg[blue]%}[$PIPENV_NAME]%{$reset_color%}$RPROMPT"
	fi


	if [[ $TERM = dumb ]] || [[ $TERM = eterm-color ]] || [[ $TERM = eat-truecolor ]]; then
		DUMB_PROMPT="$RPROMPT"
        RPROMPT=
	fi

    PROMPT="%B%{$fg[blue]%}%n@%{$fg[yellow]%}%m%{$fg[white]%}:%{$fg[red]%}%~        $DUMB_PROMPT
%{$CMD_COLOR%}>%{$reset_color%}%b "
}
fi # starship

# Reglage du terminal
if [[ $TERM = dumb ]]; then
    # disable weird escape sequences
    unsetopt zle
else
	. ~/sh_script/tab_cd.sh
	tab_cd "$(test -e ~/.pwd && cat ~/.pwd)"
	alias cd='tab_cd'

    # TERM=xterm-256color
    # Correction de la touche Delete / ctrl-left / ctrl-right
    bindkey "\e[3~"   delete-char
    bindkey "\e[1;5D" backward-word
    bindkey "\e[1;5C" forward-word
    bindkey "\e[3;5~" kill-word

    # bind alt-z to fg
    _fg() { fg }
    zle -N fg _fg
    bindkey "^[z" fg
fi

SAVEHIST=$HISTFILESIZE
setopt APPEND_HISTORY

# setopt BANG_HIST                 # Treat the '!' character specially during expansion.
# setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
# setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
# setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
# setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
# setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
# setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
# setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
# setopt HIST_BEEP                 # Beep when accessing nonexistent history.


# report the status of backgrounds jobs immediately
setopt notify

# custom comp for make / docker (sloooow)
# fpath=(~/.zsh_fpath $fpath)
# export FPATH=~/.zsh_fpath:$FPATH

# Autocompletion de type menu
zstyle ':completion:*' menu select
zstyle ':completion:*:*:make:*' tag-order 'targets'
autoload -Uz compinit promptinit && compinit && promptinit
setopt COMPLETE_ALIASES

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
zstyle ':completion:*' rehash true #refresh $PATH commands
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh.d/cache

#Fuzzy matching:
# zstyle ':completion:*' completer _complete _match _approximate
# zstyle ':completion:*:match:*' original only
# zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Don't send SIGHUP to background processes when the shell exits.
# setopt nohup

# avoid "beep"ing
setopt nobeep

# correct typo
unsetopt correct_all  # correct only command
setopt correct

# des couleurs pour la complétion
zmodload zsh/complist
setopt extendedglob


# Couleur prompt
autoload -U colors && colors

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'


# Plugins
local zsh_plugin_dir=/usr/share/zsh/plugins
for p in zsh-syntax-highlighting zsh-autosuggestions; do
    local plugin=$zsh_plugin_dir/$p/$p.zsh
    test -e $plugin && source $plugin
done


# fzf
test -e /usr/share/fzf/completion.zsh \
    && source /usr/share/fzf/completion.zsh
# test -e /usr/share/fzf/key-bindings.zsh \
#     && source /usr/share/fzf/key-bindings.zsh
# export FZF_CTRL_T_OPTS="--preview '{bat --color=always {} || tree -C {}} 2> /dev/null | head -500'"
# export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -500'"
# _fzf_compgen_dir() {
#   fd --type d --hidden --follow --exclude ".git" . "$1"
# }



# hash mcfly 2>/dev/null && eval "$(mcfly init zsh)"


# TODO: get familiar with these funny tools: bat fd fzf rg
# https://remysharp.com/2018/08/23/cli-improved

# export OPAMEXTERNALSOLVER=$(which packup 2> /dev/null)

# OPAM configuration
# . /home/mc/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true


# fortune | cowsay -n | lolcat -v 1 -h 0.2


# add completion on aliases
setopt complete_aliases
