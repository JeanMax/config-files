#!/bin/bash -e

# 1.1 GB of free space needed

TMP_FILE="$1"


test_write() {
    dd if=/dev/zero of="$TMP_FILE" bs=1M count=1024 conv=fdatasync,notrunc status=progress
}

test_read() {
    echo 3 > /proc/sys/vm/drop_caches
    dd if="$TMP_FILE" of=/dev/null bs=1M count=1024 status=progress
}

test_cache() {
    dd if="$TMP_FILE" of=/dev/null bs=1M count=1024 status=progress
}


if ! test -n "$1"; then
    echo "Specify a FILE path to create for benchmarking (we're gonna delete it, you've been warn)" >& 2
    echo "Usage: $0 FILE" >& 2
    exit 42
fi
if test "$2"; then
    echo "Usage: $0 FILE" >& 2
    exit 42
fi
if test -e "$TMP_FILE"; then
    echo "File already exists!" >& 2
    exit 42
fi

for f in test_write test_read # test_cache
do
    echo "+ $f"
    sync
    $f |& grep '1,0 GiB'
done
rm -f "$TMP_FILE"
