#!/bin/bash -e

req=/tmp/kraken.req
tmp=/tmp/kraken.tmp
price_file=~/kraken.price-db

while true; do
    curl -sS -X POST -o "$tmp" \
         --max-time 10 \
         --data pair=XXBTZEUR \
         https://api.kraken.com/0/public/Ticker
    test "$(jq ".error[0]" < "$tmp")" == "null" \
        && break || true
    sleep 3
done
jq '.result.XXBTZEUR' < "$tmp" > "$req"


# a="$(jq -r '.a[0]' < "$req" | cut -d. -f1)" # Ask
# b="$(jq -r '.b[0]' < "$req" | cut -d. -f1)" # Bin
c="$(jq -r '.c[0]' < "$req" | cut -d. -f1)" # last (Current?)
p="$(jq -r '.p[1]' < "$req" | cut -d. -f1)" # average (Pondered?)

rm -f "$req"

# Variation
if [ $c -gt $p ]; then
    v="+$(($c - $p))"
    color="#359859" # green
else
    v="$(($c - $p))"
    color="#cd5542" # red
fi

date "+P %Y/%m/%d %H:%M:%S ₿ $c€" > "$tmp"
mv "$tmp" "$price_file"
# avoid other scripts reading the file while we are writing in it

# echo "₿ $a / $b ($v)" # full text
# echo "₿ $a / $b" # short text
echo "₿ $c ($v)" # full text
echo "₿ $c" # short text
echo "$color" # color
