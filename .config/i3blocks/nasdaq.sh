#!/bin/bash

addr="https://www.boursorama.com/bourse/trackers/cours/1rTPUST/"
html=$(curl -s "$addr" | grep -A 2 "c-faceplate__price")

variation=$(echo "$html" | grep % | sed -E 's|.*data-ist-variation>(.*)%<.*|\1|')
price=$(echo "$html" | grep EUR | sed -E 's|.*data-ist-last>([^<]*).*|\1|')

base=33.49732
var=$(echo "($price/$base-1)*100" | bc -l | sed -E 's/(.*\...).*/\1/')

if echo "$variation" | grep -qE '^\+' ; then
    color="#359859" # green
else
    color="#cd5542" # red
fi

echo "€ $(echo "$price" | sed -E 's/0+$//') ($variation% $var%)"  # full text
echo "€ $(echo "$price" | sed -E 's/0+$//')"  # short text
echo "$color" # color
