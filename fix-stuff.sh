#!/usr/bin/env fish

echo 'Remapping caps to escape'
setxkbmap -option "caps:swapescape"

sleep 2
echo 'Fixing screen'
$HOME/dotfiles/screen/fix-screen.sh

# The shortcut fix doesn't work if there isn't a slep after the screen fix
sleep 2

echo 'Fixing shortcuts'
$HOME/dotfiles/fix-shortcuts.sh

