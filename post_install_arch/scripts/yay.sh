#!/usr/bin/env bash

if [ -x "$(command -v yay)" ]; then
  echo "Yay has already been installed. Skipping."
  exit 0;
fi

sudo pacman -Syu

cd $HOME

# Just to be sure
rm -rf yay

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Cleanup
cd ..
rm -rf yay

yay -Syu
