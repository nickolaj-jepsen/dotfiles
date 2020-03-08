#!/bin/sh
set -e

CONFIG_DIR="$HOME/.config/init/config"

if [ -z "$1" ]; then 
    echo "Error 101: No argument passed to config runner"
    exit 101
fi

PRE_SCRIPT="$CONFIG_DIR/$1/init.sh"
POST_SCRIPT="$CONFIG_DIR/$1/post.sh"
DEFAULT_SCRIPT="$CONFIG_DIR/$1/default.sh"
HOST_SCRIPT="$CONFIG_DIR/$1/$(hostname).sh"

if [ -x "$PRE_SCRIPT" ]; then
    # shellcheck source=/dev/null
    sh "$PRE_SCRIPT"
fi

if [ -x "$HOST_SCRIPT" ]; then
    # shellcheck source=/dev/null
    sh "$HOST_SCRIPT"
else
    # shellcheck source=/dev/null
    sh "$DEFAULT_SCRIPT"
fi

if [ -x "$POST_SCRIPT" ]; then
    # shellcheck source=/dev/null
    sh "$POST_SCRIPT"
fi

