#!/bin/bash

export LC_TIME=fr_FR.UTF-8

case $BLOCK_BUTTON in
    1) gsimplecal ; date '+%H:%M  %a %e %b';;
    *) date '+%H:%M  %a %e %b' ;;
esac
