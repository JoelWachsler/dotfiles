#!/usr/bin/env python

from mutil import cmd

def doc():
  return 'Used to install various programs after arch linux has been installed'

def install():
  cmd('./scripts/post-install.sh')
