#!/usr/bin/env bash

MIN=1
if [ ! -z ${1+x} ]; then MIN=$1; fi

WS=$(i3-msg -t get_workspaces | tr , '\n' | grep '"num":' | cut -d: -f2 | sort -n | tr '\n' ' ')

for val1 in ${WS[*]}; do
	if [[ " ${WS[@]} " =~ " $MIN " ]]; then
		MIN=$(($MIN+1))
		continue
	else
		NUM=$MIN
		break
	fi
done

WS=$(i3-msg -t get_config | sed -n '/#<workspaces/,/#workspaces>/p' | sed '/workspaces/d' | cut -d'"' -f2 | sort -n| cat -n | sed "${NUM}q;d" | cut -d '	' -f2)

# i3-msg -q workspace ${WS}
echo ${WS}
