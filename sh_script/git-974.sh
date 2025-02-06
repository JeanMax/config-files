#!/bin/bash

short=$(git rev-parse --short HEAD)
commits=$(git log --branches --remotes --pretty=format:"%h")
while true; do
    rand_bytes=$(head -c2 /dev/urandom | xxd -p | head -c3)
    gitc0ffee --update-ref --prefix 974"$rand_bytes"
    short=$(git rev-parse --short HEAD)
    grep -q "$short" <<< "$commits" || break
done
