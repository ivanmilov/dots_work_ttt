#!/bin/bash

CURRENT=`bspc query -N -n`
BIGGEST=`bspc query -N -n biggest.window.local`
MARKED=`bspc query -N -n any.local.marked`
if [ $CURRENT = $BIGGEST ]; then
	if [[ ! -z $MARKED ]];then
		bspc node -s $MARKED
		bspc node $MARKED -g marked=off
		bspc node $CURRENT -g marked
	fi
else
	bspc node biggest.window.local -g marked
	bspc node $CURRENT -g marked=off
	bspc node -s biggest.window.local
fi
