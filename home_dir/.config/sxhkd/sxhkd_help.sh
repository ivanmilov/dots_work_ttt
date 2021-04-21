#!/bin/bash

awk '/^[a-z]/ && last {print "<small>",substr($0,0,35),"\t",last,"</small>"} {last=""} /^#/{last=substr($0,2,35)}' ~/.config/sxhkd/sxhkdrc |
    column -t -s $'\t' |
    rofi -dmenu -i -markup-rows
