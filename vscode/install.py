#!/usr/bin/env python

from mutil import cmd

def doc():
  return 'Installs VSCode, configures it and installs the extensions defined in "extensions.txt"'

# Lets install extensions
def getExtensions():
  with open('vscode/extensions.txt', 'r') as f:
    return f.read().split()

def install():
  cmd('yay -S visual-studio-code-bin --noconfirm')
  cmd('mkdir -p $HOME/.config/Code/User/')
  cmd('ln -s $HOME/dotfiles/vscode/*.json $HOME/.config/Code/User/')

  for ext in getExtensions():
    cmd(f'code --install-extension {ext}')
