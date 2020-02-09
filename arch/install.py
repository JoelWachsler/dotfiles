import os, re
from mutil import cmd, run, cp, rm, getFileContents, writeFileContent

# --------------- CONSTANTS START ---------------
# Size in MB
UEFI_FROM = 1
UEFI_TO = 257
# Size in GB
SWAP_SIZE = 6
DIR_PATH = os.path.dirname(os.path.realpath(__file__))
# --------------- CONSTANTS END ---------------

# --------------- UTILS START ---------------
def rel(path):
  return f'{DIR_PATH}/{path}'

def cprint(str):
  print(f'--- {str} ---')

def chroot(command):
  cmd(f'arch-chroot /mnt {command}')

def cpFromVariousToEtc(file):
  return cp(rel(f'various-files/{file}'), f'/mnt/etc/{file}')

def cpIntoUserHome(user):
  try:
    userHome = f'/home/{user}'
    userHomePathDotfiles = f'/mnt{userHome}/dotfiles'

    # Just to be sure
    rm(userHomePathDotfiles)

    # Lets copy ourselves into the installation
    cp(rel('../'), userHomePathDotfiles)
    chroot(f'chown -R {user} {userHome}/dotfiles')
  except Exception as e:
    raise Exception(f'Failed to copy ourselves into the installation - {e}')

# --------------- UTILS END ---------------

def parted(disk):
  def partedOnDisk(command):
    return cmd(f'parted {disk} {command}')
  return partedOnDisk

def diskSetup():
  cprint('The following disks are available')
  cmd('lsblk')
  cprint('END')

  disk = input('Which disk should I install to? ex: sdX: ')
  diskToInstallTo = f'/dev/{disk}'

  cprint('Wiping the disk...')
  cmd(f'wipefs -a {diskToInstallTo}')

  partedDisk = parted(diskToInstallTo)
  partedDisk('mklabel gpt')
  partedDisk(f'mkpart primary fat32 {UEFI_FROM}MB {UEFI_TO}MB')
  partedDisk('set 1 esp on')
  partedDisk(f'mkpart primary ext4 {UEFI_TO}MiB 100%')

  cprint('The final partition is as follows:')
  partedDisk('print')
  input('Press enter to continue...')

  nvmeInput = ''
  while nvmeInput not in ['Y', 'n']:
    nvmeInput = input('Installing to nvme? [Y/n]')
    break
  except KeyboardInterrupt:
    raise
  except:
    pass
  extra = ''
  if nvmeInput == 'Y':
    extra = 'p'

  cprint('Crypto setup')
  cryptDisk = f'{diskToInstallTo}{extra}2'
  while True:
    try:
      cmd(f'cryptsetup luksFormat {cryptDisk}')
      break
    except KeyboardInterrupt:
      raise
    except:
      pass

  while True:
    try:
      cmd(f'cryptsetup open {cryptDisk} cryptlvm')
      break
    except KeyboardInterrupt:
      raise
    except:
      pass

  cprint('LVM setup')
  lvmGroupName = 'lvm'
  cryptLvmPath = '/dev/mapper/cryptlvm'
  cmd(f'pvcreate {cryptLvmPath}')
  cmd(f'vgcreate {lvmGroupName} {cryptLvmPath}')
  cmd(f'lvcreate -L {SWAP_SIZE}G {lvmGroupName} --name swap')
  swapDisk = f'/dev/{lvmGroupName}/swap'
  cmd(f'lvcreate -l 100%FREE {lvmGroupName} --name root')
  rootDisk = f'/dev/{lvmGroupName}/root'

  cprint('Formatting')
  cmd(f'mkfs.vfat {diskToInstallTo}{extra}1')
  cmd(f'mkfs.ext4 {rootDisk}')

  cprint('Enabling swap')
  cmd(f'mkswap {swapDisk}')
  cmd(f'swapon {swapDisk}')

  # Mount partitions
  cprint('Mounting partitions')
  cmd(f'mount {rootDisk} /mnt')
  cmd(f'mkdir /mnt/boot')
  cmd(f'mount {diskToInstallTo}{extra}1 /mnt/boot')

  # Returning the crypt device grub should decrypt
  return cryptDisk

def initIntoMnt():
  # Install mirror-lists
  cprint('Updating mirrors')
  cp(rel('various-files/mirrorlist'), '/etc/pacman.d/mirrorlist')

  # Install essential packages
  cprint('Installing essentials')
  cmd('pacstrap /mnt base base-devel linux linux-firmware neovim dhcpcd man-db man-pages intel-ucode grub efibootmgr fish git python python-pip cmake xz pigz lvm2')

def generateFStab():
  cprint('Generating fstab')
  fstabContent = run('genfstab -U /mnt').stdout
  # Add tmpfs
  fstabContent += 'tmpfs   /tmp         tmpfs   rw,nodev,nosuid          0  0\n'
  writeFileContent('/mnt/etc/fstab', fstabContent)

def setupNewSystem():
  # Setup region
  cprint('Setting up the region')
  chroot('ln -sf /usr/share/zoneinfo/Europe/Stockholm /etc/localtime')

  # Generate /etc/adjtime
  cprint('Generate /etc/adjtime')
  chroot('hwclock --systohc')

  # Generate localization
  cprint('Generate localization')
  cpFromVariousToEtc('locale.gen')
  chroot('locale-gen')

  cpFromVariousToEtc('locale.conf')
  cpFromVariousToEtc('vconsole.conf')

  # Update makepkg
  cpFromVariousToEtc('makepkg.conf')

  # Fix networking
  cpFromVariousToEtc('hostname')
  cpFromVariousToEtc('hosts')
  chroot('systemctl enable dhcpcd')

def setupUsers(user):
  cprint('Changing the shell for root')
  chroot('chsh -s /usr/bin/fish')

  while True:
    try:
      cprint('Change root password')
      chroot('passwd')
      break
    except KeyboardInterrupt:
      raise
    except:
      pass

  chroot(f'useradd -m -G wheel -s /usr/bin/fish {user}')
  while True:
    try:
      cprint('Password for the new user:')
      chroot(f'passwd {user}')
      break
    except KeyboardInterrupt:
      raise
    except:
      pass

  sudoers = '/mnt/etc/sudoers'
  contentToWrite = getFileContents(sudoers).replace('# %wheel ALL=(ALL) ALL', '%wheel ALL=(ALL) ALL').replace('root ALL=(ALL) ALL\n', f'root ALL=(ALL) ALL\n{user} ALL=(ALL) ALL\n')

  writeFileContent(sudoers, contentToWrite)

def enableMultiLibs():
  cprint('Enabling multilibs')
  pacmanConf = '/mnt/etc/pacman.conf'
  contentToWrite = getFileContents(pacmanConf).replace('#[multilib]\n#Include = /etc/pacman.d/mirrorlist', '[multilib]\nInclude = /etc/pacman.d/mirrorlist')

  writeFileContent(pacmanConf, contentToWrite)

def updateMkinitcpio():
  cprint('Configuring Mkinitcpio')
  file = '/mnt/etc/mkinitcpio.conf'
  content = getFileContents(file)
  content = content.replace('#COMPRESSION="xz"', '#COMPRESSION="xz"\nCOMPRESSION="pigz"')
  pattern = r'^HOOKS=\((.*)\)$'
  hooks = re.findall(pattern, content, re.MULTILINE)[0]
  hooks = hooks.replace('block', 'block keymap encrypt')
  hooks = hooks.replace('filesystems', 'lvm2 filesystems')
  content = re.sub(pattern, f'HOOKS=({hooks})', content, flags=re.MULTILINE)
  writeFileContent(file, content)
  chroot('mkinitcpio -p linux')

def configureGrub(cryptDevice):
  cprint('Configuring grub')
  grubFile = '/mnt/etc/default/grub'
  grubContent = getFileContents(grubFile).replace('GRUB_CMDLINE_LINUX=""', f'GRUB_CMDLINE_LINUX="cryptdevice={cryptDevice}:crypt"')
  writeFileContent(grubFile, grubContent)

  chroot('grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=arch_grub --recheck')
  chroot('grub-mkconfig -o /boot/grub/grub.cfg')

def doc():
  return 'Installs arch linux'

def install():
  user = input('Which user shall I install as: ')
  # Locale and clock syncing
  cmd('loadkeys sv-latin1')
  cmd('timedatectl set-ntp true')

  cryptDevice = diskSetup()
  initIntoMnt()
  generateFStab()
  setupNewSystem()
  setupUsers(user)
  updateMkinitcpio()
  configureGrub(cryptDevice)
  enableMultiLibs()
  cpIntoUserHome(user)
  cprint('DONE!')
  cprint('Restart and run "./dotfiles --arch_post_install"')
