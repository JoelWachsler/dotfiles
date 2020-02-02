#!/usr/bin/env python

from mutil import cmd

def install(user, script):
  cmd(f'su {user} -P -c "cd /home/{user}/dotfiles/arch_post_install/scripts && ./{script}"')
