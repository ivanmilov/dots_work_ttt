#!/bin/bash

# awk '/^#[a-z]/ && last {print "<small>",substr($0,2,35),"\t",last,"</small>"} {last=""} /^##/{last=$0}' ~/.config/dxhd/dxhd.sh |
awk '/^#[a-z]/ && last {print substr($0,2),"\t",substr(last,3)} {last=""} /^##/{last=$0}' ~/.config/dxhd/dxhd.sh |
    column -t -s $'\t' |
    rofi -dmenu -i -markup-rows -theme-str '#window { width: 1300;}'

