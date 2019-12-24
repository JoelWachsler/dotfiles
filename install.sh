#!/usr/bin/env bash

echo "Installing xinit"
ln -s $HOME/dotfiles/xinit/.xinitrc $HOME/.xinitrc
echo "Done!"

echo "Installing Ranger config files"
ln -s $HOME/dotfiles/ranger/* $HOME/.config/ranger/
echo "Done!"

echo "Running neovim installation script"
./nvim/install.sh
echo "Done!"

echo "Installing autostart entries"
ln -s $HOME/dotfiles/autostart/* $HOME/.config/autostart/
echo "Done!"

