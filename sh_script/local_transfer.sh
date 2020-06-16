#!/bin/bash
set -e

# COMPRESS=z

usage() {
    cat <<EOF
Usage:
$0 recv
$0 send IP_ADDR FILE
EOF
    exit 42
}

recv() {
    nc -vlp "$PORT" | tar -xv"$COMPRESS"
}

send() {
    (tar -cv"$COMPRESS"pf - "$FILE" && sync && sleep 1 && pkill -f "nc -v $IP $PORT") \
        | nc -v "$IP" "$PORT"
}


PORT=4242
CMD="$1"

if test "$CMD" = recv; then
    recv
elif test "$CMD" = send; then
    IP="$2"
    FILE="$3"
    if ! test "$IP" || ! test "$FILE"; then
        usage
    fi
    send
else
    usage
fi

echo "yay!"
