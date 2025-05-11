#!/bin/bash

flake8 $@ && pylint $@
