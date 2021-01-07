#!/bin/bash

xautolock \
	# -corners ++-- \
	-cornerdelay 5 \
	-detectsleep \
	-time 10 \
	-locker "$HOME/.config/i3/scripts/lock.sh" \
	-notify 30 \
	-notifier "notify-send -u critical -t 10000 -- 'LOCKING screen in 30 seconds'"