# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    tab_emacs.sh                                       :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/08/19 13:12:36 by mcanal            #+#    #+#              #
#    Updated: 2016/07/30 18:29:52 by mcanal           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

if [ -z "$1" ]; then
	echo "Give me a file, boy...";
#elif [ ! -f "$1" ]; then
#	echo "I'm pretty sure you're stoned again...";
#elif [ -d "$1" ]; then
#	echo "Dired mod? Seriouslee? Nah...";
else	
	echo -n "\033]0;$(basename "$1")\007";
	$EDITOR "$@"
fi;
