#!/usr/bin/env fish

sudo dislocker -v -V /dev/sdb1 -u -- /mnt/tmp
sudo mount -o loop /mnt/tmp/dislocker-file $HOME/disk
