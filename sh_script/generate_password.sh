#!/bin/bash

PASSWORD_LENGTH=32
WITH_SPECIAL_CHAR=t

PATTERN='A-Za-z0-9'

if test $WITH_SPECIAL_CHAR; then
    PATTERN+='@&_=,?!:;~#|/%$^()[]{}'
fi


head /dev/urandom \
    | tr -dc $PATTERN \
    | head -c $PASSWORD_LENGTH
# echo ''
