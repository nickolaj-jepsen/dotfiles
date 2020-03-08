#! /bin/sh

if ! command -v xrandr; then
    echo "Error 102: xrandr needs to be installed to detected the default monitor"
    exit 102
fi

FIRST_MONITOR=xrandr --listmonitors | grep '+' | awk '{ print $4 }' | head --lines 1

feh --bg-fill --recursive /home/nickolaj/Pictures/ee.png 

bspc monitor $FIRST_MONITOR -d web code term music chat
