#!/bin/bash -xe

SWAP_DEVICE=$(swapon --show=name --noheadings)
USED_SWAP=$(free --mega | grep Swap | sed -E 's|Swap:\s*[0-9]*\s*([0-9]*).*|\1|')
FREE_MEM=$(free --mega | grep Mem  | sed -E 's|.*\s([0-9]*)$|\1|')

test "$SWAP_DEVICE"
((USED_SWAP != 0))
((FREE_MEM > USED_SWAP))

sync
swapoff "$SWAP_DEVICE"
swapon "$SWAP_DEVICE"
