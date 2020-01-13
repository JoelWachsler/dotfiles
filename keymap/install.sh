#!/usr/bin/env bash

# test -f $HOME/dotfiles/keymap/xkbmap.xkb && xkbcomp $HOME/dotfiles/keymap/xkbmap.xkb $DISPLAY
sudo ln -s $HOME/dotfiles/keymap/90-custom-kbd.conf /usr/share/X11/xorg.conf.d/

