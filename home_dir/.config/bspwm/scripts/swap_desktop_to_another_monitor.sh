#!/bin/bash

n=0

# save current desktop
curr_desk_id=$(bspc query -D -d)

# get focused monitor
while read -r line
do
    [[  $n == 0 ]] && m0="$line"
    [[  $n == 1 ]] && m1="$line"
    [[  $n == 2 ]] && m2="$line"
    n=$(($n + 1))
done < <(bspc query -M)

mon_id=$( bspc query -M -m focused )
[[ $mon_id == $m0 ]] && mon_id=$m1

# get target monitor
[[ $mon_id == $m1 ]] && target_mon=$m2 || target_mon=$m1

# focus target monitor
bspc monitor -f $target_mon

# go to new free desktop
bspc desktop -f any.local.\!occupied

# swap with saved desktop
bspc desktop -s $curr_desk_id
