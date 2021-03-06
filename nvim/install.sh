#!/usr/bin/env bash

cd $HOME/.config/
mkdir -p nvim
cd nvim
ln -s $HOME/dotfiles/nvim/init.vim .

echo "Installing vim-plug"
curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Installing plugins"
pip install neovim --user
nvim --headless +PlugInstall +UpdateRemotePlugins +qa
