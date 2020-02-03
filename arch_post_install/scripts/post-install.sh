#!/usr/bin/env bash

cd $HOME/dotfiles/arch_post_install/scripts
./yay.sh
./kde.sh
# ./i3.sh
./various-programs.sh
# ./dislocker.sh
./generate-ssh-key.sh

# Then install other various programs
cd $HOME/dotfiles
./dotfiles.sh --everything
