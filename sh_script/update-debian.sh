#!/bin/bash -xe

apt update
apt dist-upgrade --show-progress
apt autoremove --show-progress
apt autoclean
