#!/bin/sh
set -e

INIT_FOLDER="$HOME/.config/init"

sh "$INIT_FOLDER/source-config.sh" x
sh "$INIT_FOLDER/source-config.sh" lockscreen
sh "$INIT_FOLDER/source-config.sh" bspwm
sh "$INIT_FOLDER/source-config.sh" sxhkd
sh "$INIT_FOLDER/source-config.sh" polybar
sh "$INIT_FOLDER/source-config.sh" dunst
sh "$INIT_FOLDER/source-config.sh" autorun
