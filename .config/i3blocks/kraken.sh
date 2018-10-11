#!/bin/bash -e

req=/tmp/kraken.req
tmp=/tmp/kraken.tmp
price_file=~/.kraken.price-db

while true; do
    curl -sS -X POST -o "$tmp" \
         --max-time 10 \
         --data pair=XXBTZEUR \
         https://api.kraken.com/0/public/Ticker
    test "$(jq ".error[0]" < "$tmp")" == "null" \
        && break || true
    sleep 5
done
jq '.result.XXBTZEUR' < "$tmp" > "$req"


a="$(jq -r '.a[0]' < "$req" | cut -d. -f1)" # Ask
# b="$(jq -r '.b[0]' < "$req" | cut -d. -f1)" # Bin
c="$(jq -r '.c[0]' < "$req" | cut -d. -f1)" # last (Current?)
p="$(jq -r '.p[1]' < "$req" | cut -d. -f1)" # average (Pondered?)

rm -f "$req"

# current--price might be total bullshit, if so we'll print ask-price instead
if [ $(($c - $a)) -gt 7 ] || [ $(($a - $c)) -gt 7 ]; then
	# echo "zboub: $c"			# DEBUG
	c=$a
fi
# echo "c:$c a:$a diff:$(($c - $a))" # DEBUG


# Variation
if [ $c -gt $p ]; then
    v="+$(($c - $p))"
    color="#359859" # green
else
    v="$(($c - $p))"
    color="#cd5542" # red
fi

# echo "₿ $a / $b ($v)" # full text
# echo "₿ $a / $b" # short text
echo "₿ $c ($v)" # full text
echo "₿ $c" # short text
echo "$color" # color


# we store the current price for other scripts (ledger mostly)
date "+P %Y-%m-%d %H:%M:%S XXBT $c ZEUR" > "$tmp"
# avoid other scripts reading the file while we are writing in it
mv "$tmp" "$price_file"
