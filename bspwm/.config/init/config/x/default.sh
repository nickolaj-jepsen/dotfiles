#! /bin/sh

xrandr --dpi 96
xrdb -merge  $HOME/.Xresources
setxkbmap -layout eu &
xsetroot -cursor_name left_ptr &
xset m 1/1 0 & # Mouse acc
xset b off &
