#!/usr/bin/env bash

# Just to be sure
rm -rf yay

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Cleanup
cd ..
rm -rf yay

yay -Syu