#!/usr/bin/env python

from mutil import cmd

def doc():
  return 'Installs VSCode, configures it and installs the extensions defined in "extensions.txt"'

def install():
  cmd('yay -S visual-studio-code-bin --noconfirm')
  cmd('mkdir -p $HOME/Code/User/')
  cmd('ln -s $HOME/dotfiles/vscode/*.json $HOME/Code/User/')

  # Lets install extensions
  def getExtensions():
    with open('vscode/extensions.txt', 'r') as f:
      return f.read().split()

  for ext in getExtensions():
    cmd(f'code --install-extension {ext}')
