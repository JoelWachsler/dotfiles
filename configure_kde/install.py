import sys, os
from mutil import cmd, cp, getFileContents, writeFileContent

DIR_PATH = os.path.dirname(os.path.realpath(__file__))

def filePath(file):
  return f'{DIR_PATH}/kde_files/{file}'

def copyToXdgHome(file):
  cp(filePath(file), f'$HOME/.config/{file}')

def runScript(script):
  cmd(f'qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "$(echo "$(cat {filePath(script)})")"')

def updateLockScreenWallpaper():
  cmd('kwriteconfig5 --file kscreenlockerrc --group Greeter --group Wallpaper --group org.kde.image --group General --key Image "file://$HOME/dotfiles/configure_kde/kde_files/wallpaper.jpg"')

def install():
  runScript('changeWallpaper.js')
  updateLockScreenWallpaper()
  # copyToXdgHome('plasma-org.kde.plasma.desktop-appletsrc')
  copyToXdgHome('plasmarc')
  copyToXdgHome('konsolerc')
  cp(filePath('Profile 1.profile'), '$HOME/.local/share/konsole/')
  copyToXdgHome('kdeglobals')
  copyToXdgHome('kglobalshortcutsrc')
  copyToXdgHome('plasmarc')
