#!/usr/bin/env bash

function install_yay {
  echo 'Installing yay'
  git clone git clone https://aur.archlinux.org/yay.git
  cd yay

  makepkg -si

  # Cleanup
  cd ..
  rm -rf yay
}

function install_various_programs {
  yay -Syu
  yay -S fish \
    jdk11-openjdk jre11-openjdk jre11-openjdk-headless openjdk11-doc openjdk11-src visualvm \
    intellij-idea-ultimate-edition \
    discord \
    spotify \
    visual-studio-code-bin \
    ttf-meslo \
    bluez bluez-utils bluedevil pulseaudio-bluetooth \
    google-chrome \
    nodejs yarn \
    docker docker-compose \
    # PDF/SVG viewer
    gwenview \
    autokey \
    neovim \
    python \
    lutris \
    steam \
    pigz xz \
    # Mouse config util
    piper \
    vlc
}

function install_dislocker {
  echo 'Installing dislocker'
  git clone https://github.com/Aorimn/dislocker.git
  cd dislocker

  cmake .
  make
  sudo make install

  # Cleanup
  cd ..
  rm -rf dislocker
}

install_yay
install_various_programs
install_dislocker

