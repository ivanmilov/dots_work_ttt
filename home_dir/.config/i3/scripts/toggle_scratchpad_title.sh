#!/usr/bin/env bash

declare -r TITLE=$1
declare -r IS_SHOW=$(i3-msg [title="$TITLE"] scratchpad show 2> /dev/null | jq '.[0].success')

if [[ $IS_SHOW == "false" ]]; then
	alacritty --title $TITLE & 
	i3-msg [title="$TITLE"] scratchpad show
fi
