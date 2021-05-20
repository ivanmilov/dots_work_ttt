#!/bin/bash

set -e
# stupid workaround to get pointed monitor
# monitor config: [DP-0](laptop:closed,disabled)] [DP-1.1] [DP-1.2]
# for some reason instead of returning [DP-1.1] it returns [DP-0] WTF!
n=0

while read -r line
do
    [[  $n == 0 ]] && m0="$line"
    [[  $n == 1 ]] && m1="$line"
    [[  $n == 2 ]] && m2="$line"
    n=$(($n + 1))
done < <(bspc query -M)

mon_id=$( bspc query -M -m pointed )
[[ $mon_id == $m0 ]] && mon_id=$m1

# stupid workaround

desk_id=$( bspc query -D -d $mon_id:focused.!occupied)

[[ -n $desk_id ]] &&  bspc desktop -f $desk_id

