#!/usr/bin/env bash

systemctl enable docker
systemctl enable bluetooth

sudo groupadd docker
sudo usermod -aG docker $USER