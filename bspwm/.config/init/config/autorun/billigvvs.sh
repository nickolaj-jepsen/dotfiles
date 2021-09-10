#!/bin/sh

chromium &
snap run pycharm-professional &
smerge &
snap run teams &
snap run slack &
kitty --class terminal-mon3-2 fish -C "ssh home -D 9999" &
kitty --class terminal-mon3-2 fish -C "pycharm" &
