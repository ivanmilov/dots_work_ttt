#!/usr/bin/env bash

# Add this script to your wm startup file.

declare -r DIR=$(dirname ${BASH_SOURCE[0]})

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done


# Launch the bar
if [[ $1 == "debug" ]]; then
    polybar -l trace left -c "$DIR"/config.ini &
    polybar -l trace right -c "$DIR"/config.ini &
elif [[ $1 == "one" ]]; then
    polybar left right -c "$DIR"/config.ini &
else
    polybar -q left -c "$DIR"/config.ini &
    polybar -q right -c "$DIR"/config.ini &
fi
