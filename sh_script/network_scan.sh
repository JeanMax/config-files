#!/bin/bash
set -e

TMP_FILE="/tmp/network_scan.log"

nmap -sn $(hostname -I | tr -d ' ')/24 | grep report > $TMP_FILE
cat $TMP_FILE | cut -d ' ' -f 5 #hostnames
IPS=$(cat $TMP_FILE | cut -d ' ' -f 6 | tr -d '()')

nmap -F $IPS
# sudo nmap -O $IPS

rm -f $TMP_FILE
