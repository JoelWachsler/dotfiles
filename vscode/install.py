#!/usr/bin/env python

from mutil import cmd

def install():
  cmd('ln -s $HOME/dotfiles/vscode/*.json $HOME/Code/User/')

  # Lets install extensions
  def getExtensions():
    with open('extensions.txt', 'r') as f:
      return f.read().split()

  for ext in getExtensions():
    cmd(f'code --install-extension {ext}')