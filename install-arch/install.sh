#!/usr/bin/env bash

# Locale
loadkeys sv-latin1

# Sync clock
timedatectl set-ntp true

### Disk setup

# Setup/format disks
# mkfs.ext4 /dev/sdX1
# Enable swap
# mkswap /dev/sdX2
# swapon /dev/sdX2

# mount /dev/sdX1 /mnt

# Install mirror-lists
cp ../various-files/mirrorlist /etc/pacman.d/mirrorlist

# Install essential packages
pacstrap /mnt base linux linux-firmware

# Generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

### Time to go into the newly installed system
arch-chroot /mnt

# Setup region
ln -sf /usr/share/zoneinfo/Europe/Stockholm /etc/localtime

# Generate /etc/adjtime
hwclock --systohc

# Generate localization
cp ../various-files/locale.gen /etc/locale.gen
locale-gen

cp ../various-files/locale.conf /etc/locale.conf
cp ../various-files/vconsole.conf /etc/vconsole.conf

# Fix networking
cp ../various-files/hostname /etc/hostname
cp ../various-files/hosts /etc/hosts
systemctl enable dhcpcd

### Create new initramfs
mkinitcpio -P

### User fixes

# Update root password
passwd

# Create a new user
usermod -aG

# Install microcode for intel
pacman -S intel-ucode

# Install grub
pacman -S grub
grub-install --target=x86_64-efi --efi-directory=esp --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

echo 'Done!'
