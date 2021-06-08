#!/bin/bash

n=0

source export_mons.sh

# save current desktop
curr_desk_id=$(bspc query -D -d)

first=$(bspc query -M --names | head -n1)

mon_id=$( bspc query -M -m focused)

# get target monitor
[[ $mon_id == $m1_id ]] && target_mon=$m2_id || target_mon=$m1_id

# focus target monitor
bspc monitor -f $target_mon

# go to new free desktop
bspc desktop -f any.local.\!occupied

# swap with saved desktop
bspc desktop -s $curr_desk_id
