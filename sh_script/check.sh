# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    check.sh                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/02/07 01:07:39 by mcanal            #+#    #+#              #
#    Updated: 2016/09/18 15:06:41 by mcanal           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

grep -R "   Created: " * | grep -v $USER >> header_test;
grep -R "   Updated: " * | grep -v $USER >> header_test;
grep -R "   By: " * | grep -v $USER >> header_test;
FILE_SIZE=$(du header_test | awk '{ print $1 }');
if [ "$FILE_SIZE" = 0 ]; then
    echo "\033[37;01mTesting header \033[32;01mOK\033[0m";
else
    echo "\033[37;01mTesting header \033[31;01mKO\033[0m";
    cat header_test;
fi
rm header_test;
echo "";

echo $USER > auteur_test;
AUTEUR=$(cat -e auteur);
AUTEUR_TEST=$(cat -e auteur_test);
if [ $AUTEUR = $AUTEUR_TEST ]; then
    echo "\033[37;01mTesting auteur \033[32;01mOK\033[0m";
else
    echo "\033[37;01mTesting auteur \033[31;01mKO\033[0m";
    cat -e auteur;
fi
rm auteur_test;
echo "";

ls -R * > ls_test;
cat ls_test | grep "\.o" > tmp_test;
cat ls_test | grep "\.a" >> tmp_test;
cat ls_test | grep "\.sw" >> tmp_test;
cat ls_test | grep "\.sv" >> tmp_test;
cat ls_test | grep "#" >> tmp_test;
cat ls_test | grep "~" >> tmp_test;
cat ls_test | grep "\.md" >> tmp_test;
cat ls_test | grep "\.sh" >> tmp_test;
FILE_SIZE=$(du tmp_test | awk '{ print $1 }');
if [ "$FILE_SIZE" = 0 ]; then
    echo "\033[37;01mTesting temp files \033[32;01mOK\033[0m";
else
    echo "\033[37;01mTesting temp files \033[31;01mKO\033[0m";
    cat tmp_test;
fi
rm ls_test;
rm tmp_test;
echo "";

norminette * > norm_test;
cat norm_test | grep -v "Norme: " | grep -v "can't check this file" > norm_test2;
FILE_SIZE=$(du norm_test2 | awk '{ print $1 }');
if [ "$FILE_SIZE" = 0 ]; then
    echo "\033[37;01mTesting norme \033[32;01mOK\033[0m";
else
    echo "\033[37;01mTesting norme \033[31;01mKO\033[0m";
    cat norm_test2 | grep --color=auto "Warning";
    cat norm_test | grep --color=auto -B 1 "Error";
fi
rm norm_test;
rm norm_test2;
