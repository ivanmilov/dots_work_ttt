#!/bin/bash

BUTTON=$1
PROG_1=$2
PROG_2=$3

LOCK=/tmp/double_click.$BUTTON.lock


if [ "$BUTTON" == "" -o "$PROG_1" == "" -o "$PROG_2" == "" ]; then
    echo "Usage : Double_Click <Button> <Program first click> <Program second click>"
    exit
fi

#echo BUTTON=$BUTTON
#echo PROG_1=$PROG_1
#echo PROG_2=$PROG_2
#
#echo LOCK=$LOCK

if [ -e $LOCK ]; then
    exec $PROG_2 &
    rm -f $LOCK
else
    echo "first click" > $LOCK
    sleep 0.2
    if [ -e $LOCK ]; then
    exec $PROG_1 &
    fi
    rm -f $LOCK
fi


