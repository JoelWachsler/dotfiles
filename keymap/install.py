import os
from mutil import cmd, writeFileContent

HOME = os.environ['HOME']

def updateProfile():
  profileLocation = f'{HOME}/.profile'
  writeFileContent(profileLocation, 'setxkbmap -layout se -option nodeadkeys,caps:escape')

def updateXinit():
  xinitrc = f'{HOME}/.xinitrc'
  writeFileContent(xinitrc, 'setxkbmap -layout se -option nodeadkeys,caps:escape')

def install():
  updateProfile()
  updateXinit()