#!/usr/bin/env bash

if [ ! -d "$HOME/.dotfiles" ]; then
    echo "Installing dotfiles for the first time"
    git clone --depth=1 https://github.com/spartDev/dotfiles.git "$HOME/.dotfiles"
    cd "$HOME/.dotfiles"
    [ "$1" = "ask" ] && export ASK="true"
    rake install
else
    echo "dotfiles is already installed"
fi
