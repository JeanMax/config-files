# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    youjam.sh                                          :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: mcanal <zboub@42.fr>                       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/05/05 16:33:51 by mcanal            #+#    #+#              #
#    Updated: 2016/09/18 15:06:41 by mcanal           ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FAIL="";

#IMPORT
if  [ "$1" = "--import" -o "$1" = "-i" ]; then
    echo "\033[37;01m--- YOUJAM IMPORT ---\033[0m";

    if [ -n "$2" ]; then
        DEST=$2;
    else
        DEST="YoujamHopesThisDirectoryIsEmptyAndHisNameUnused";
    fi;

    if [ -n "$3" -o -e $DEST ]; then
        echo "Usage: $0 -i [DEST]";
        exit;
    fi;

    echo "Assuming DEST='$DEST'.";
    if [ -z "$2" ]; then
        echo "Are you sure you want to continue (yes/no)?";
        read -p "> " ANSWER;
        case "$ANSWER" in
            [Yy]|[Yy][Ee][Ss] ) ;;
            * ) exit ;;
        esac;
    fi;

    mkdir $DEST 2>/dev/null;

    echo "\n\033[37;01mCloning clean fuel folder...\033[0m";
    git clone git://github.com/fuel/fuel.git clean_fuel || FAIL="git error (fuel)";

    if [ -z "$FAIL" ]; then
        echo "\n\033[37;01mCloning youjam folder...\033[0m";
        git clone https://github.com/JeanMax/youjam.git fresh_jam || FAIL="$FAIL git error (youjam)";
    fi;

    if [ -z "$FAIL" ]; then
        echo "\n\033[37;01mMerging folders...\033[0m";
        rm -rf fresh_jam/.git clean_fuel/.git && echo ".git deleted" || FAIL="rm error (.git)";
        cp -r fresh_jam/. clean_fuel/. && echo "fusion done" && cp -r clean_fuel/. $DEST/. && echo "files moved" || FAIL="$FAIL cp error";
        rm -rf fresh_jam clean_fuel && echo "temporary files deleted" || FAIL="$FAIL rm error (clones)";
    fi;

    if [ -z "$FAIL" ]; then
        echo "\n\033[37;01mUpdating fuel...\033[0m";
        cd $DEST && php composer.phar self-update && php composer.phar update && cd - || FAIL="update error";
    fi;

    if [ -z "$FAIL" ]; then
        echo "\n\033[32;01mReady to jam!\033[0m";
    else
        echo "\n\033[31;01mJam is gonna wait...\033[0m";
        echo $FAIL;
        if [ "$DEST" != "." ]; then
            rm -rf $DEST; #it may not be a so good idea...
        fi;
        echo "\033[37;01mClones cleaned.\033[0m";
    fi;

    #EXPORT
elif [ "$1" = "--export" -o "$1" = "-e" ]; then
    echo "\033[37;01m--- YOUJAM EXPORT ---\033[0m";

    if [ -z "$2" ]; then
        SRC=".";
        DEST="YoujamHopesThisDirectoryIsEmptyAndHisNameUnused";
    elif [ -z "$3" ]; then
        SRC=".";
        DEST=$2;
    else
        SRC=$2;
        DEST=$3;
    fi;

    if [ -n "$4" -o "$DEST" = "$SRC" -o -e $DEST ]; then
        echo "Usage: $0 -e [SRC] [DEST]";
        exit;
    fi;

    echo "Assuming SRC='$SRC' and DEST='$DEST'.";
    if [ -z "$2" -o -z "$3" ]; then
        echo "Are you sure you want to continue (yes/no)?";
        read -p "> " ANSWER;
        case "$ANSWER" in
            [Yy]|[Yy][Ee][Ss] ) ;;
            * ) exit ;;
        esac;
    fi;

    echo "\n\033[37;01mCloning youjam folder...\033[0m";
    git clone https://github.com/JeanMax/youjam.git $DEST || FAIL="git error";

    if [ -z "$FAIL" ]; then
        echo "\n\033[37;01mCopying files...\033[0m";
        mkdir $DEST/fuel 2>/dev/null;# || FAIL="mkdir error (fuel)";
        echo -n ".";
        mkdir $DEST/fuel/app 2>/dev/null;#|| FAIL="$FAIL mkdir error (app)";
        echo -n ".";
        cp $SRC/README.md $DEST/. || FAIL="$FAIL cp error";
        echo -n ".";
        cp -r $SRC/public $DEST/. || FAIL="$FAIL cp error (public)";
        echo -n ".";
        cp -r $SRC/fuel/.htaccess $DEST/fuel/. || FAIL="$FAIL cp error (.htaccess)";
        echo -n ".";
        cp -r $SRC/fuel/app/bootstrap.php $DEST/fuel/app/. || FAIL="$FAIL cp error (bootstrap)";
        echo -n ".";
        cp -r $SRC/fuel/app/classes $DEST/fuel/app/. || FAIL="$FAIL cp error (classes)";
        echo -n ".";
        cp -r $SRC/fuel/app/config $DEST/fuel/app/. || FAIL="$FAIL cp error (config)";
        echo -n ".";
        cp -r $SRC/fuel/app/migrations $DEST/fuel/app/. || FAIL="$FAIL cp error (migrations)";
        echo -n ".";
        cp -r $SRC/fuel/app/views $DEST/fuel/app/. || FAIL="$FAIL cp error (views)";
        echo ".";
    fi;

    if [ -z "$FAIL" ]; then
        echo "done";
        echo "\n\033[37;01mGit Status:\033[0m";
        cd $DEST && git status && cd -;

        echo "\n\033[32;01mReady to jam!\033[0m";
    else
        echo "\n\033[31;01mJam is gonna wait...\033[0m";
        echo $FAIL;
        if [ "$DEST" != "." ]; then
            rm -rf $DEST; #it may not be a so good idea...
        fi;
    fi;
else
    echo "Usage: $0 OPTION [SRC] [DEST]";
    echo "--import, -i : clone fuel and youjam, then merge them";
    echo "--export, -e : copy the files needed for youjam's git";
fi;
