#! /bin/sh
xrandr --output DP-4 --primary --mode 2560x1440 --rate 144.00
xrandr --output DP-0 --left-of DP-4
xrandr --output DP-3 --right-of DP-4

bspc monitor DP-4 -d web code term music chat
bspc monitor DP-3 -d mon2-1 mon2-2
bspc monitor DP-0 -d mon3-1 mon3-2

# feh --bg-fill --recursive /home/nickolaj/Pictures/ee.png 
