#!/bin/sh

if ! [ -x "$(command -v fish)" ]; then
    echo 'Fish is not installed'
    exit 1
fi

curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/fisher/functions/fisher.fish
fish -c 'fisher'
