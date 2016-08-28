#!/bin/bash
set -e

test $# = 1 || (echo "wut?" 1>&2; exit 1)
find "$1" -type f -print0 | xargs --null chmod 644
find "$1" -type d -print0 | xargs --null chmod 755
