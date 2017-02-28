#!/bin/bash

case $BLOCK_BUTTON in
    1) gsimplecal ; date '+%H:%M  %a %e %b';;
    *) date '+%H:%M  %a %e %b' ;;
esac
