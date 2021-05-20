#!/bin/bash
# simple script to hide/ make visible windows in bspwm

function usage(){
	echo "Usage:"
	echo "unhide <hide|unhide>"
}

function hide(){
	# hide active window
	bspc node -g hidden
}

function unhide(){
	# create an array
	hiddenWindows=( $(bspc query -N -n .hidden) )

	# if list of hidden windows is empty, just exit
	[ -z $hiddenWindows ] && exit

	# forming name, showing with rofi
	for i in ${!hiddenWindows[@]}
	do
		# hiddenWindows[$i]=${hiddenWindows[$i]}" "$(xprop -id ${hiddenWindows[$i]} | grep NET_WM_NAME )
		hiddenWindows[$i]=${hiddenWindows[$i]}" "$(xprop -id ${hiddenWindows[$i]} | grep NET_WM_NAME | awk '{print $3}')
	done

	# showing rofi
	# choice=$(printf "%s\n" "${hiddenWindows[@]}" | awk '{$2="";$3=""; print $0}' | rofi -dmenu -p "Hidden:" | awk '{print $1}')
	choice=$(printf "%s\n" "${hiddenWindows[@]}"  | rofi -dmenu -p "Hidden:" | awk '{print $1}')

	# if choice given, move window to active desktop
	# make it visible
	# focus it
	if [ -n $choice ]
	then
		bspc node $choice -d $(bspc query -d -D focused)
		bspc node $choice -g hidden=off
		bspc node -f $choice
	else
		exit
	fi
}

case $1 in
	hide)hide;;
	unhide)unhide;;
	*)usage;;
esac
