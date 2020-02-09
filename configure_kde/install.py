import sys, os
from mutil import cmd, cp, getFileContents, writeFileContent

DIR_PATH = os.path.dirname(os.path.realpath(__file__))

def filePath(fileRelToCurrentDir):
  return f'{DIR_PATH}/{fileRelToCurrentDir}'

def restoreDesktopLayout():
  content = getFileContents(filePath('plasma-org.kde.plasma.desktop-appletsrc'))
  content = content.replace('WALLPAPER_PATH', filePath('wallpaper.jpg'))
  writeFileContent('$HOME/.config/plasma-org.kde.plasma.desktop-appletsrc', content)

def install():
  restoreDesktopLayout()
  cp(filePath('konsole/konsolerc'), '$HOME/.config/konsolerc')
  cp(filePath('konsole/Profile 1.profile'), '$HOME/.local/share/konsole/')
