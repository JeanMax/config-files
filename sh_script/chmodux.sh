#!/bin/bash
set -e

test $# = 1 || (echo "$0 FILE" 1>&2; exit 1)
find "$1" -type f -print0 | xargs --null chmod -c 644
find "$1" -type d -print0 | xargs --null chmod -c 755
