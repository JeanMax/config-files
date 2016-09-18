#!/bin/bash
set -e

ME="$0"

SERVER="moi"
# SERVER="plizz"

function _usage () {
    cat << EOF >&2
Usage: $ME [OPTION] [SRC] [DST] [RSYNC_OPTION]...
     -s, --send: send file from localhost/SRC to server/DST.
     -g, --get: get file from server/SRC localhost/DST.
EOF
}

function _sync () {
    RSYNC_FLAGS="-harvz --progress --stats"

    rsync $RSYNC_FLAGS $@ --dry-run

    echo "### rsync $RSYNC_FLAGS $@ ###"
    echo "$WARN"
    echo "Are you sure you want to continue (yes/no)?";
    read -p "> " ANSWER;
    case "$ANSWER" in
	    [Yy]|[Yy][Ee][Ss] ) ;;
	    * ) exit ;;
    esac;

    rsync $RSYNC_FLAGS $@
}

if [ "$1" == "-s" ] || [ "$1" == "--send" ]; then
    test $# -lt 3 && _usage && exit 1
    WARN="~~~ localhost:$2 -> server:$3 ~~~"
    _sync "$2" "$SERVER:$3" "${@:4}"
elif [ "$1" == "-g" ] || [ "$1" == "--get" ]; then
    test $# -lt 3 && _usage && exit 1
    WARN="~~~ server:$2 -> localhost:$3 ~~~"
    _sync "$SERVER:$2" "$3" "${@:4}"
else
    _usage
    echo -e "\nNo OPTION given, starting ssh session..."
    echo -e "### ssh $SERVER -C -D 1080 ###\n"
    ssh "$SERVER" -C -D 1080
fi
