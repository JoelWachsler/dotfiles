#!/usr/bin/env bash

echo "Installing autostart entries"
mkdir -p $HOME/.config/autostart
mkdir -p $HOME/.config/autostart-scripts
ln -s $HOME/dotfiles/autostart/autostart/* $HOME/.config/autostart/
ln -s $HOME/dotfiles/autostart/autostart-scripts/* $HOME/.config/autostart-scripts/
