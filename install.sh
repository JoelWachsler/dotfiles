#!/usr/bin/env fish

# echo "Installing xinit"
# ln -s $HOME/dotfiles/xinit/.xinitrc $HOME/.xinitrc

echo "Installing Ranger config files"
ln -s $HOME/dotfiles/ranger/* $HOME/.config/ranger/

echo "Running fish install script"
./fish/install.sh

echo "Running neovim installation script"
./nvim/install.sh

echo "Installing autostart entries"
ln -s $HOME/dotfiles/autostart/* $HOME/.config/autostart/
ln -s $HOME/dotfiles/autostart-scripts/* $HOME/.config/autostart-scripts/

echo "Fixing keyboard"
setxkbmap -layout se -option nodeadkeys,caps:escape