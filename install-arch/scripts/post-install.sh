#!/usr/bin/env bash

git clone https://github.com/JoelWachsler/dotfiles
cd $HOME/dotfiles/install-arch/scripts
./yay.sh
./kde.sh
# ./i3.sh
./various-programs.sh
# ./dislocker.sh
# runScript('various-programs.sh', user)
# runScript('dislocker.sh', user)
./generate-ssh-key.sh

# Then install other various programs
cd $HOME/dotfiles
./install.sh
