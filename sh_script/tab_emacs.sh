# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    tab_emacs.sh                                       :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/08/19 13:12:36 by mcanal            #+#    #+#              #
#    Updated: 2016/06/30 11:51:32 by mcanal           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

if [ -z "$1" ]; then
	echo "Give me a file, boy...";
#elif [ ! -f "$1" ]; then
#	echo "I'm pretty sure you're stoned again...";
# elif [ -d "$1" ]; then
	# echo "Dired mod? Seriouslee? Nah...";
else	
	echo -n "\033]0;$(basename "$1")\007";
	emacs24 -nw $1 $2 $3 $4 $5 $6 $7 $8 $9;
fi;
