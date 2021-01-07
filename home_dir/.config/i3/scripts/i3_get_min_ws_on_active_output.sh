#!/usr/bin/env bash

ACTIVE_OUTPUT=$(i3-msg -t get_workspaces | jq '.[] | select(.focused == true) | {output: .output}' | grep output | sed 's/[ \"]//g' |cut -d: -f2)

i3-msg -t get_config | sed -n '/#<outputs/,/#outputs>/p'| sed 's/workspace $ws//g' | grep $ACTIVE_OUTPUT | head -n1 | cut -d ' ' -f1
