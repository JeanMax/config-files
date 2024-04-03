#!/bin/sh -x

alacritty msg create-window $@ || alacritty $@
