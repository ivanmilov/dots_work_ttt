#!/bin/bash

mon_num=`bspc query -M | wc -l`

export m1=$(( mon_num - 1 ))
export m2=$mon_num

export m1_id=`bspc query -M | sort | sed -n '1 p' `
export m2_id=`bspc query -M | sort | sed -n '2 p' `
