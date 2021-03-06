#!/bin/bash
set -e

# TMP_FILE="/tmp/network_scan.log"

# IP=$(ifconfig | grep 'inet ' | grep -v '127.0.0.1' | cut -d' ' -f10)
# nmap -sn $IP/24 | grep report > $TMP_FILE
# # cat $TMP_FILE | cut -d ' ' -f 5 #hostnames
# # IPS=$(cat $TMP_FILE | cut -d ' ' -f 6 | tr -d '()')
# IPS=$(cat $TMP_FILE | cut -d ' ' -f 5)

# nmap -F $IPS
# # sudo nmap -O $IPS

# rm -f $TMP_FILE

IP=$(ifconfig | grep -v '127.0.0.1' | grep -Eo 'inet .* ' | cut -d' ' -f2)
if (( EUID != 0 )); then
	NMAP_FLAGS=-sn
else
	NMAP_FLAGS=-O
fi
grc -es --colour=auto nmap $NMAP_FLAGS $IP/24
