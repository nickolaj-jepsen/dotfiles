#! /bin/sh

firefox &
nextcloud &
slack &
charm &
# google-chrome-stable &
kitty --class=kitty-proxy --detach ssh -D9090 staging &
