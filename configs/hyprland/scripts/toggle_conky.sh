#!/usr/bin/env bash

# Check if conky is already running
if pgrep -x "conky" > /dev/null
then
    # if true kill all conky instances
    killall conky
else
    # if false start conky
    conky
fi
