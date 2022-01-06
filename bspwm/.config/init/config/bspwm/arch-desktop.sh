#! /bin/sh
xrandr --output DP-2 --primary --mode 2560x1440 --rate 144.00
xrandr --output HDMI-0 --left-of DP-2
xrandr --output DP-1 --right-of DP-2

bspc monitor DP-2 -d web code term music chat
bspc monitor HDMI-0 -d mon3-1 mon3-2
bspc monitor DP-1 -d mon2-1 mon2-2

# feh --bg-fill --recursive /home/nickolaj/Pictures/ee.png 
