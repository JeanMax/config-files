# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    who.sh                                             :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/02/12 20:45:28 by mcanal            #+#    #+#              #
#    Updated: 2016/09/18 15:06:41 by mcanal           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

rm who;
touch who;
clear;
while true;
do
    w -h | grep -v $USER > who
    SIZE_A=$(du who | awk '{ print $1 }');
    if [ "$SIZE_A" != 0 -a "$SIZE_A" != "$SIZE_B" ];
    then
        echo "\033[31;01mWATCH OUT!\033[0m";
        w;
        tput bel; say "WATCH OUT!";
        BRANDON=$(w -h | grep -v $USER | awk '{ print $1 }');
        yes "SSH forbidden in here. Violators will be shot, survivors will be shot again. " | write "$BRANDON";
    fi
    SIZE_B=$(du who | awk '{ print $1 }');
    sleep 1;
done
