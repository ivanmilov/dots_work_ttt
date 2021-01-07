#!/bin/bash

IS_SHOW=$(i3-msg scratchpad show 2> /dev/null | jq '.[0].success')
[[ $IS_SHOW == "false" ]] && i3-msg [floating] move scratchpad
