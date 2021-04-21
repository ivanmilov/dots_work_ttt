#!/bin/bash

bspc subscribe desktop_focus | while read -r line; do
    id=$(bspc query -N -n focused)
    [[ -n "$id" ]] && xdotool set_window --urgency 0 $id
done
