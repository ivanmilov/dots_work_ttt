#!/bin/bash

set -e

mon_id=$(get_pointed_monitor_id)

desk_id=$( bspc query -D -d $mon_id:focused.!occupied)

[[ -n $desk_id ]] &&  bspc desktop -f $desk_id

