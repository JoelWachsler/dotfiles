#!/usr/bin/env python

import subprocess, os
# Swap size is in MiB
UEFI_FROM = 1
UEFI_TO = 261
SWAP_SIZE = 6000
SWAP_SIZE_FROM = UEFI_TO
SWAP_SIZE_TO = SWAP_SIZE_FROM + SWAP_SIZE

def arg(command):
  return os.path.expandvars(command).split()

def cmd(command):
  return subprocess.call(arg(command))

def run(command):
  return subprocess.run(arg(command), stdout=subprocess.PIPE, universal_newlines=True)

def cprint(str):
  print(f'--- {str} ---')

def diskSetup():
  cprint('The following disks are available')
  cmd('lsblk')
  cprint('END')

  cprint('Which disk should I install to? ex: sdX')
  diskToInstallTo = f'/dev/{input()}'

  cprint('Wiping the disk...')
  cmd(f'wipefs -a {diskToInstallTo}')

  cmd(f'parted {diskToInstallTo} mklabel gpt')
  cmd(f'parted {diskToInstallTo} mkpart primary fat32 {UEFI_FROM}MiB {UEFI_TO}MiB')
  cmd(f'parted {diskToInstallTo} set 1 esp on')
  cmd(f'parted {diskToInstallTo} mkpart primary linux-swap {SWAP_SIZE_FROM}MiB {SWAP_SIZE_TO}MiB')
  cmd(f'parted {diskToInstallTo} mkpart primary ext4 {SWAP_SIZE_TO}MiB 100%')
  cprint('The final partition is as follows:')
  cmd(f'parted {diskToInstallTo} print')

  cprint('Formatting')
  cmd(f'mkfs.vfat {diskToInstallTo}1')
  cmd(f'mkfs.ext4 {diskToInstallTo}3')

  cprint('Enabling swap')
  cmd(f'mkswap {diskToInstallTo}2')
  cmd(f'swapon {diskToInstallTo}2')

  # Mount partitions
  cprint('Mounting partitions')
  cmd(f'mount {diskToInstallTo}3 /mnt')
  cmd(f'mkdir /mnt/boot')
  cmd(f'mount {diskToInstallTo}1 /mnt/boot')

def initIntoMnt():
  # Install mirror-lists
  cprint('Updating mirrors')
  cmd('cp ../various-files/mirrorlist /etc/pacman.d/mirrorlist')

  # Install essential packages
  cprint('Installing essentials')
  cmd('pacstrap /mnt base base-devel linux linux-firmware vim dhcpcd man-db man-pages intel-ucode grub efibootmgr fish')

def generateFStab():
  cprint('Generating fstab')
  fstabInfo = run('genfstab -U /mnt')
  with open('/mnt/etc/fstab', 'w') as f:
    f.write(fstabInfo.stdout)
  cprint('Done generating fstab!')

def chroot(command):
  cmd(f'arch-chroot /mnt {command}')

def setupNewSystem():
  # Setup region
  cprint('Setting up the region')
  chroot('ln -sf /usr/share/zoneinfo/Europe/Stockholm /etc/localtime')

  # Generate /etc/adjtime
  cprint('Generate /etc/adjtime')
  chroot('hwclock --systohc')

  # Generate localization
  cprint('Generate localization')
  cmd('cp ../various-files/locale.gen /mnt/etc/locale.gen')
  chroot('locale-gen')

  cmd('cp ../various-files/locale.conf /mnt/etc/locale.conf')
  cmd('cp ../various-files/vconsole.conf /mnt/etc/vconsole.conf')

  # Fix networking
  cmd('cp ../various-files/hostname /mnt/etc/hostname')
  cmd('cp ../various-files/hosts /mnt/etc/hosts')
  chroot('systemctl enable dhcpcd')

def setupUsers():
  cprint('Change root password')
  chroot('passwd')

  cprint('Your username: ')
  username = input()
  chroot(f'useradd -m -G wheel -s /usr/bin/fish {username}')
  cprint('Password for the new user:')
  chroot(f'passwd {username}')

  contentToWrite = ''
  with open('/mnt/etc/sudoers', 'r') as f:
    content = f.read()
    content = content.replace('# %wheel ALL=(ALL) ALL', '%wheel ALL=(ALL) ALL')
    contentToWrite = content.replace('root ALL=(ALL) ALL\n', f'root ALL=(ALL) ALL\n{username} ALL=(ALL) ALL\n')

  with open('/mnt/etc/sudoers', 'w') as f:
    f.write(contentToWrite)

def installGrub():
  cprint('Installing grub')
  chroot('grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB')
  chroot('grub-mkconfig -o /boot/grub/grub.cfg')

def installYay():
  cprint('Installing yay')
  chroot('git clone git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si && cd .. && rm -rf yay')

def installVariousPrograms():
  cprint('Installing various programs')
  chroot("""yay -Syu && yay -S fish \
    jdk11-openjdk jre11-openjdk jre11-openjdk-headless openjdk11-doc openjdk11-src visualvm \
    intellij-idea-ultimate-edition \
    discord \
    spotify \
    visual-studio-code-bin \
    ttf-meslo ttf-ms-fonts ttf-opensansss \
    qbittorrent \
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
    vlc \
    ffmpeg \
    mullvad-vpn-bin \
    openssh \
    ranger \
    rsync""")

def installKde():
  cprint('Installing KDE')
  chroot('yay -Syu && yay -S plasma-meta sddm')

def installDislocker():
  cprint('Installing dislocker')
  chroot('git clone https://github.com/Aorimn/dislocker.git && cd dislocker && cmake . && sudo make install cd .. && rm -rf dislocker')

def generateSshKey():
  cprint('Generating ssh key')
  cprint('Input email: ')
  email = input()
  chroot(f'ssh-keygen -t rsa -b 4096 -C "{email}" && ssh-add')

def enableMultiLibs():
  cprint('Enabling multilibs')

def main():
  # Locale and clock syncing
  cmd('loadkeys sv-latin1')
  cmd('timedatectl set-ntp true')

  diskSetup()
  initIntoMnt()
  generateFStab()
  setupNewSystem()
  setupUsers()
  installGrub()
  installYay()
  installKde()
  installVariousPrograms()
  installDislocker()
  generateSshKey()
  cprint('DONE!')

if __name__ == '__main__':
  main()
