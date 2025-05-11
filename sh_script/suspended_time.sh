#!/bin/bash

ac -a -d -y

journalctl \
    --since "$(date -d 'Sep  6 2022' '+%Y-%m-%d')" \
    --until "$(date -d 'Sep  7 2022' '+%Y-%m-%d')" \
    -t systemd-sleep \
    | grep -v Boot \
    | cut -d' ' -f-3
