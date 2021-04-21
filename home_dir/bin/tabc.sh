#!/bin/sh

# Usage:
# tabc.sh <command>
# Commands:
#    add <direction-of-tabbed> <window-id> - Add window to tabbed
#    remove <window-id> - Remove window from tabbed
#    list <tabbed-id> - List all clients of tabbed

#
# Functions
#

# Get wid of root window
get_root_wid()
{
    xwininfo -root | awk '/Window id:/{print $4}'
}

# Get children of tabbed
get_clients() 
{
    id=$1
    xwininfo -id $id -children | sed -n '/[0-9]\+ \(child\|children\):/,$s/ \+\(0x[0-9a-z]\+\).*/\1/p'
}

# Get class of a wid
get_class() 
{
    id=$1
    if [ -z $id ]; then
        echo ""
    else
        xprop -id $id | sed -n '/WM_CLASS/s/.*, "\(.*\)"/\1/p'
    fi
}

put_all_to_tabbed()
{
    win_list=$(bspc query -N -n .window -d focused)
    tabbedid=$(tabbed -c -d)
    for wid in $win_list; 
    do
        xdotool windowreparent $wid $tabbedid
    done
    # Lock tabbed node to not close all the windows accidentally
    bspc node -g locked
}

#
# Main Program
#

cmd=$1
if [ $cmd = "add" ]; then
    tabbedid=$(bspc query -N -n $2)
    if [ -z $tabbedid ]; then
        tabbedid=$(tabbed -c -d)
    fi
fi


case $cmd in
    add)
        wid=$3
        xdotool windowreparent $wid $tabbedid
        ;;
    remove)
        wid=$2
        xdotool windowreparent $wid $(get_root_wid)
        ;;
    list)
        tabbedid=$2
        get_clients $tabbedid
        ;;
    all)
        put_all_to_tabbed
        ;;

esac
