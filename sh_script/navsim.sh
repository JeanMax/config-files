#!/bin/bash -x

export VHC=$VHC
export FILTER_VHC=$(sed 's/SIMU\|ECU/%/' <<< "$VHC")


VHC=${VHC:-EZ10-Gen3B-nocoder-SIMU}  # TEZ-Gen2-6t-188w-nocoder-SIMU
TEST="$1"

test "$TEST" || { echo "Error: Script arg should be a navsim test name." 1>&2; exit 42; }


#TODO: add no docker option

touch tests/navsim/conftest.py
./docker/docker.sh \
    -t test.navsim.$(grep -q ECU <<< $VHC && echo ecu || echo simu)."$TEST.$VHC" \
    make
