#!/usr/bin/env python

from mutil import cmd

def doc():
  return 'Used to install various programs after arch linux has been installed'

def install():
  cmd('./arch_post_install/scripts/post-install.sh')
