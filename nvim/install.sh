#!/usr/bin/env bash

cd $HOME/.config/
mkdir -p nvim
cd nvim
ln $HOME/dotfiles/nvim/init.vim .

echo "Installing vim-plug"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Installing plugins"
pip install neovim --user
nvim -c "PlugInstall"
nvim -c "UpdateRemotePlugins"
