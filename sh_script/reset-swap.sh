#!/bin/bash -xe

MIN_SWAP_FOR_RESET=50 # mega

USED_SWAP=$(free --mega | grep Swap | sed -E 's|Swap:\s*[0-9]*\s*([0-9]*).*|\1|')
((USED_SWAP > MIN_SWAP_FOR_RESET)) || exit 0

FREE_MEM=$(free --mega | grep Mem  | sed -E 's|.*\s([0-9]*)$|\1|')
((FREE_MEM > USED_SWAP)) || exit 0

SWAP_DEVICE=$(swapon --show=name --noheadings)
test "$SWAP_DEVICE" || exit 0

sync
swapoff "$SWAP_DEVICE"
swapon "$SWAP_DEVICE"
