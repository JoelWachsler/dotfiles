#!/usr/bin/env python

import subprocess, os, dbus

def expand(command):
  return os.path.expandvars(command)

def cmd(command):
  subprocess.call(expand(command), shell=True)

def setwallpaper(filepath, plugin = 'org.kde.image'):
  script = """
  var allDesktops = desktops();
  print (allDesktops);
  for (i=0;i<allDesktops.length;i++) {
      d = allDesktops[i];
      d.wallpaperPlugin = "%s";
      d.currentConfigGroup = Array("Wallpaper", "%s", "General");
      d.writeConfig("Image", "file://%s")
  }
  """
  bus = dbus.SessionBus()
  plasma = dbus.Interface(bus.get_object('org.kde.plasmashell', '/PlasmaShell'), dbus_interface='org.kde.PlasmaShell')
  plasma.evaluateScript(script % (plugin, plugin, filepath))

cmd('yay -S plasma-meta sddm')
cmd('systemctl enable sddm')
setwallpaper('$HOME/dotfiles/wallpaper/wallpaper.jpg')
