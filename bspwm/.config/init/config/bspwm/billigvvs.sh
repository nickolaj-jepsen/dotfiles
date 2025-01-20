#!/bin/sh
xrandr --output HDMI-1 --mode 1920x1080 --pos 0x336 --rotate normal --output HDMI-2 --primary --mode 1920x1200 --pos 1920x288 --rotate normal --output VIRTUAL-1 --off --output VGA-1 --mode 1920x1200 --pos 3840x0 --rotate left

bspc monitor HDMI-2 -d web code term music chat
bspc monitor HDMI-1 -d mon2-1 mon2-2
bspc monitor VGA-1 -d mon3-1 mon3-2
