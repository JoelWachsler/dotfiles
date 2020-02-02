#!/usr/bin/env python

import sys
sys.path.append('../')
from mutil import cmd

email = input('Input email: ')
cmd(f'ssh-keygen -t rsa -b 4096 -C "{email}" && ssh-add')
