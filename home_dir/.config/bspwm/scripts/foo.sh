#!/bin/bash



bspc subscribe node_remove | while read -r line; do
        did=`echo $line | awk '{print $3}'`
        ncnt=`bspc query -N -d $did`
        echo $did $ncnt
done




# bspc subscribe node_remove | while read -r line; do
#     desktop_id=`echo "$line" | cut -d " " -f 3`
#     empty=`bspc query -D -d $desktop_id.!occupied`
#     if [[ $desktop_id == empty ]]; then

#     fi
#     # id=$(bspc query -N -n focused)
#     # [[ -n "$id" ]] && xdotool set_window --urgency 0 $id
# done
