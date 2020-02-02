#!/usr/bin/env python

from arch.util import cmd

email = input('Input email: ')
cmd(f'ssh-keygen -t rsa -b 4096 -C "{email}" && ssh-add')
