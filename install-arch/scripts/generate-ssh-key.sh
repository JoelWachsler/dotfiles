#!/usr/bin/env python

import subprocess

def cmd(command):
  return subprocess.call(arg(command), shell=True)

email = input('Input email: ')
cmd(f'ssh-keygen -t rsa -b 4096 -C "{email}" && ssh-add')
