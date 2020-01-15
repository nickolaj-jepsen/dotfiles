#!/usr/bin/bash
export MON1="HDMI1"
export MON2="DP1"

xrandr --output HDMI2 --off --output HDMI1 --mode 2560x1440 --pos 0x0 --rotate normal --output DP1 --mode 1920x1200 --pos 2560x0 --rotate left --output eDP1 --off

bspc monitor $MON2 -d mon2-1 mon2-2
bspc config --monitor $MON2 top_padding 5
polybar external &

bspc monitor $MON1 -d web code term music chat
feh --bg-fill --recursive /home/nickolaj/Pictures/wallpapers/deer.jpg 
polybar top &
bspc wm --adopt-orphans
