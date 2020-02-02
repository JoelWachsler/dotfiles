#!/usr/bin/env python

import sys
sys.path.append('../')
from mutil import cmd

cmd('pip install dbus-python --user')
import dbus

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
