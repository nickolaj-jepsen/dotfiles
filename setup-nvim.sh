#!/bin/sh

if ! [ -x "$(command -v nvim)" ]; then
    echo 'NeoVim is not installed'
    exit 1
fi

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
