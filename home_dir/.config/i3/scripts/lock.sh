#!/bin/bash

# https://github.com/nonpop/xkblayout-state
current_lang=`xkblayout-state print %s`
[ $current_lang = "ru" ] && xkblayout-state set +1;

set -o errexit -o noclobber -o nounset

HUE=(-level 0%,100%,0.6 -set colorspace Gray -separate -average)
# EFFECT=(-scale 10% -scale 1000%)
EFFECT=(-scale 5% -scale 2000%)
# IMAGE="$(mktemp).png"
IMAGE="/home/i/tmp/lock.png"

# move pipefail down as for some reason "convert -list font" returns 1
set -o pipefail
# trap 'rm -f "$IMAGE"' EXIT

SCRIPTPATH="/usr/share/i3lock-fancy"

scrot -zo "$IMAGE"
ICON="$HOME/.config/i3/icons/lock.png"

LOCK=()
while read LINE
do
    if [[ "$LINE" =~ ([0-9]+)x([0-9]+)\+([0-9]+)\+([0-9]+) ]]; then
        W=${BASH_REMATCH[1]}
        H=${BASH_REMATCH[2]}
        Xoff=${BASH_REMATCH[3]}
        Yoff=${BASH_REMATCH[4]}
        MIDXi=$(($W / 2 + $Xoff - 128  / 2))
        MIDYi=$(($H / 2 + $Yoff - 135  / 2))
        LOCK+=($ICON -geometry +$MIDXi+$MIDYi -composite)
    fi
done <<<"$(xrandr)"

convert "$IMAGE" "${HUE[@]}" "${EFFECT[@]}" "${LOCK[@]}" "$IMAGE"

i3lock -n -i "$IMAGE"
