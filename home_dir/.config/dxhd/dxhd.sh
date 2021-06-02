#!/bin/bash

term=konsole
term_fallback=terminator

##
## wm independent hotkeys
##

## terminal emulator
#super + {_,shift + } Return
	{$term, $term_fallback}
	# alacritty || terminator

## program launcher
## super + @space
## 	dmenu_run

## program launcher rofi
#super + d
	rofi -combi-modi window,drun -show combi -modi combi -matching fuzzy

## make dxhd reload its configuration files:
#super + Escape
	dxhd -r; notify-send 'dxhd' 'Reloaded config'

## show help
#super + F1
	~/.config/dxhd/dxhd_help.sh

## htop
#super + i
	$term -e htop

## libinput gestures restart
#super + alt + g
	libinput-gestures-setup restart; notify-send 'libinput-gestures-setup' 'restart'

## flameshot gui
#ctrl + Print
	flameshot gui

## rofi calc https://github.com/svenstaro/rofi-calc
#super + ctrl + d
	rofi -plugin-path ~/proj/rofi-calc/build/.libs -show calc -modi calc -no-show-match -no-sort

## lock screen
#super + shift + l
	~/.config/i3/scripts/lock.sh

## picom transparency change
#super + ctrl + {equal,minus,r}
	/home/i/proj/picom/bin/picom-trans -c {+5,-5,-r}

## Password manager
#super + p
	/home/i/.config/i3/scripts/pss.sh

## Clipboard manager
#ctrl + alt + c
	rofi -modi "clipboard:greenclip print" -show clipboard -run-command '{cmd}'

##
## bspwm hotkeys
##

## quit/restart bspwm
#super + alt + {q,r}
	bspc {quit,wm -r}

## close and kill
#super + {_,shift + }q
	bspc node -{c,k}

## alternate between the tiled and monocle layout
## super + o
## 	bspc desktop -l next

## send the newest marked node to the newest preselected node
## super + y
## 	bspc node newest.marked.local -n newest.!automatic.local

## swap the current node and the biggest window
#super + g
	bspc node -s biggest.window.local || bspc node -s last.local
	# ~/.config/bspwm/scripts/swap_biggest.sh

## bsp_layout_swither (super + h; l) for help
##super + {_,alt +} l
##	bsp_layout_switcher {"",set}

## bsp_layout_swither for help
#super + l
	double_click.sh	"bsp_layout_switcher" "bsp_layout_switcher"  "bsp_layout_switcher set"

## show layout_swither help
#super + ctrl + l
	alacritty --class HELP,HELP -e less ~/.config/bspwm/scripts/bsp_layout_switcher_help.txt

##
## state/flags
##

## switch (tiled,pseudo_tiled,floating,fullscreen)
#super + {t,shift + t,shift + f,f}
	bspc node -t '~{tiled,pseudo_tiled,floating,fullscreen}'

## set the node (marked,locked,sticky,private)
#super + ctrl + {m,x,y,z}
	bspc node -g {marked,locked,sticky,private}

##
## focus/swap
##

## focus/swap the node in the given direction
## super + {_,shift + }{Left,Down,Up,Right}
## 	bspc node -{f,s} {west,south,north,east}

## super + {Left,Down,Up,Right}
## 	bspc node -f {west,south,north,east}

## focus node in the given direction
#super + {Down,Up}
	bspc node -f {south,north}

## allows to focuw
## focus node/desktop in the given direction
#super + {Left,Right}
	DIR={west,east}; \
	bspc node -f $DIR || bspc monitor -f $DIR

## Swap focused window with the one in the given direction.  If there is
## no window in that direction, a receptacle will be created.  Inputting
## any direction again will move the focused window to the position of
## the receptacle.  This will effectively remove it from the current
## layout, creating a more fluid workflow that does not constrain you to
## the tree of the tiling scheme.
##
## IF you only ever want to move a window into an existing one and avoid
## the added features of the scripted behaviour, use the following
## command instead:
##
## 	bspc node -s {west,south,north,east}
##
## TIP after breaking free from the layout, you can use --balance to
## spread out the nodes (see the key chord further down).  You may also
## --rotate the tree.
##
## bspwm_smart_move is part of my dotfiles (link in the description).
##bspwm_smart_move {west,south,north,east}
#super + shift + {Left,Down,Up,Right}
	DIR={west,south,north,east}
	MOVE=""
	case $DIR in
	west )
        MOVE='-20 0' ;;
    south )
        MOVE='0 20' ;;
    north )
        MOVE='0 -20' ;;
	east )
        MOVE='20 0' ;;
esac
	bspwm_smart_move $DIR || bspc node -v $MOVE




## focus the node for the given path jump
## super + {p,b,comma,period}
## 	bspc node -f @{parent,brother,first,second}

## focus the next/previous window in the current desktop
#super + {_,shift + }c
	bspc node -f {next,prev}.local.!hidden.window

## focus the next/previous desktop in the current monitor
#ctrl + alt + {Left,Right}
	bspc desktop -f {prev,next}.occupied

## focus the last node/desktop
#super + {grave,Tab}
	SEL={node,desktop}; \
	[[ $SEL == "node" ]] && PARAM=".local"; \
	bspc $SEL -f older$PARAM

## move node to last desktop
#super + shift + Tab
	bspc node -d older -f

## focus or send to the given desktop
## #super + {_,alt} + {_,shift} + {1-9,0}
## 	MON={'2','3'}; \
## 	SEL={'desktop -f','node -d'}; \
## 	FOLLOW=`[[ $SEL == 'node -d' ]] && echo --follow`; \
## 	bspc `echo $SEL` ^$MON:^{1-9,10} $FOLLOW

#super + {_,shift} + {1-9,0}
	SEL={'desktop -f','node -d'};
	N={1-9,10};
	FOLLOW=`[[ $SEL == 'node -d' ]] && echo --follow`;
	double_click.sh "desktop" "bspc $SEL ^2:^$N $FOLLOW" "bspc $SEL ^3:^$N $FOLLOW"

## open/move_to next new desktop
#super + {_, shift} + n
	SEL={'desktop -f','node -d'}; \
	FOLLOW=`[[ $SEL == 'node -d' ]] && echo --follow`; \
	bspc `echo $SEL` any.local.\!occupied $FOLLOW
	# bspc `echo $SEL` any.\!occupied $FOLLOW

##move desktop to monitor
#super + alt + {Left,Right}
swap_desktop_to_another_monitor.sh {no, matter}
## bspc desktop -m {prev,next} --follow

## bspc desktop -m {prev,next} --follow && \
## bspc query -M | while read -r monitor; do \
##     bspc query -D -m "$monitor" -d .occupied --names | sort -g | xargs -rd'\n' bspc monitor "$monitor" -o; \
## done

##
## preselect
##

## preselect{cancel} the direction
#super + ctrl + shift + {Left,Down,Up,Right}
	bspc node --presel-dir '~{west,south,north,east}'

## preselect the ratio
##super + ctrl + {1-9}
## bspc node -o 0.{1-9}

## cancel the preselection for the focused nodeLeft,Down
## super + ctrl + shift + space
## 	bspc node -p cancel

## Move current window to a pre-selected space
#super + ctrl + shift + m
	bspc node -n last.!automatic --follow

## cancel the preselection for the focused desktop
#super + ctrl + shift + space
	bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel

##
## Tabbed
##

##super + w; {Left,Down,Up,Right}
## Add window to tabbed
#super + ctrl + shift + {Left,Down,Up,Right}
	tabc.sh add {west,south,north,east} $(bspc query -N -n focused)

## #super + w; r
## Remove window from tabbed
#super + ctrl + shift + r
 	tabbed=$(bspc query -N -n focused); \
 	child=$(tabc.sh list $tabbed | head -n1); \
 	tabc.sh remove $child

##super + w; a
## Move all windows to new tabbed
#super + ctrl + shift + a
	tabc.sh all

## Clear urgent flag from node
##super + w; u
##	xdotool set_window --urgency 0 $(bspc query -N -n focused)

##
## move/resize
##

## resize
#super + ctrl + {Left,Down,Up,Right}
	STEP=20; SELECTION={1,2,3,4}; \
	bspc node -z $(echo "left -$STEP 0,bottom 0 $STEP,top 0 -$STEP,right $STEP 0" | cut -d',' -f$SELECTION) || \
	bspc node -z $(echo "right -$STEP 0,top 0 $STEP,bottom 0 -$STEP,left $STEP 0" | cut -d',' -f$SELECTION)

## contract a window by moving one of its side inward
#super + ctrl + alt + {Left,Down,Up,Right}
	bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}

## Go to working desktop
#super + {_,shift} + m
	bspc {desktop -f,node -d} ^3:^5 --follow

#super + k
	/home/i/.config/polybar/my/launch.sh
	# bspc node -R 90
	# bspc node -f @parent; \
	# bspc desktop -B
	# bspc node -f @parent; bspc node -F horizontal
	# pkill sxhkd ; sleep 4; /usr/local/bin/sxhkd -r ~/tmp/sx.out

	# sleep 1; xset dpms force standby


## Rotate
#super + r
	bspc node @parent -R 90

## Dynamic gaps.
#super + ctrl + bracket{left,right}
	bspc config -d focused window_gap "$(($(bspc config -d focused window_gap) {-,+} 5 ))"


## hide/unhide
#super + {_,shift} + v
	unhider.sh {unhide, hide}

## click on empty desktop make it active
##~mouse1
##	click_select_empty_desktop.sh

## go to urgent desktop
#super + u
	bspc desktop -f 'any.urgent'
