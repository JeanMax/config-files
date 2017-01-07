#!/bin/bash
set -xe

apt-get update
apt-get dist-upgrade --show-progress
apt-get autoremove --show-progress
apt-get autoclean
