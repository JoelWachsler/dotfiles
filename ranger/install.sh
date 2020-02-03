#!/usr/bin/env bash

echo "Installing Ranger config files"
mkdir -p $HOME/.config/ranger
ln -s $HOME/dotfiles/ranger/* $HOME/.config/ranger