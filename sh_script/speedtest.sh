#!/bin/bash

MAX=20

sum=0
for i in $(seq 1 $MAX); do
    current=$(speedtest --no-upload | grep 'Download:' | cut -d' ' -f2)
    sum=$(echo "$sum + $current" | bc -l)
    average=$(echo "$sum / $i" | bc -l | sed -E 's/(.*\.[0-9]{,2}).*/\1/')

    echo "Current: $current Mbit/s - Average: $average Mbit/s"
done
