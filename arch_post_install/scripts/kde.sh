#!/usr/bin/env bash

yay -S
  sddm \
  plasma \
  networkmanager plasma-nm \
  bluedevil \
  ksysguard \
  powerdevil \
  breeze-grub \
  breeze-gtk kde-gtk-config \
  ffmpegthumbs kdegraphics-thumbnailers \
  gwenview \
  kalgebra kcalc \
  dolhin dolphin-plugins filelight \
  konsole \
  okular \
  spectacle \
  samba cifs-utils \
  kscreen \
  alsa-utils \
  --noconfirm

systemctl enable sddm
systemctl enable networkmanager
