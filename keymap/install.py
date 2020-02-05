import os
from mutil import cmd

HOME = os.environ['HOME']

def writeFileContents(file, contents):
  with open(file, 'w') as f:
    f.write(contents)

def updateProfile():
  profileLocation = f'{HOME}/.profile'
  writeFileContents(profileLocation, 'setxkbmap -layout se -option nodeadkeys,caps:escape')

def install():
  updateProfile()