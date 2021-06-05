#!/bin/bash

mon_num=`bspc query -M | wc -l`

export m1=$(( mon_num - 1 ))
export m2=$mon_num
