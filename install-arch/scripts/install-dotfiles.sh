#!/usr/bin/env bash

git clone https://github.com/JoelWachsler/dotfiles
cd $HOME/dotfiles/install-arch/scripts
./yay.sh
./kde.sh
# runScript('various-programs.sh', user)
# runScript('dislocker.sh', user)
./generate-ssh-key.sh


cd $HOME/dotfiles
./install.sh
