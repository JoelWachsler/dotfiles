#!/usr/bin/env python

import subprocess, os

def cmd(command):
  return subprocess.check_call(os.path.expandvars(command), shell=True)

cmd('ln -s $HOME/dotfiles/vscode/*.json $HOME/Code/User/')

# Lets install extensions
def getExtensions():
  with open('extensions.txt', 'r') as f:
    return f.read().split()

for ext in getExtensions():
  cmd(f'code --install-extension {ext}')
