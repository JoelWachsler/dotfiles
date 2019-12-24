#!/bin/sh

cd $HOME/.config/
mkdir -p nvim
cd nvim
ln $HOME/dotfiles/nvim/init.vim .
echo "Done installing vim config files"

echo "Installing vim-plug"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "Done installing vim-plug!"
