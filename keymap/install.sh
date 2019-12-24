#!/usr/bin/env bash

test -f $HOME/dotfiles/keymap/xkbmap.xkb && xkbcomp $HOME/dotfiles/keymap/xkbmap.xkb $DISPLAY

