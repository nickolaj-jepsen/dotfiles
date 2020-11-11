#!/bin/sh
xrandr --output HDMI2 --mode 1920x1080 --pos 0x336 --rotate normal --output HDMI1 --primary --mode 1920x1200 --pos 1920x288 --rotate normal --output VIRTUAL1 --off --output VGA1 --mode 1920x1200 --pos 3840x0 --rotate left

bspc monitor HDMI1 -d web code term music chat
bspc monitor HDMI2 -d mon2-1 mon2-2
bspc monitor VGA1 -d mon3-1 mon3-2
