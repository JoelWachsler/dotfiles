import os
from mutil import cmd, run, cp, rm

# --------------- CONSTANTS START ---------------
# Swap size is in MiB
UEFI_FROM = 1
UEFI_TO = 261
SWAP_SIZE = 6000
SWAP_SIZE_FROM = UEFI_TO
SWAP_SIZE_TO = SWAP_SIZE_FROM + SWAP_SIZE
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

def runScript(script, user):
  try:
    cprint(f'Running the script: {script}')
    userHome = f'/home/{user}'
    userHomePathDotfiles = f'/mnt{userHome}/dotfiles'

    # Just to be sure
    rm(userHomePathDotfiles)

    # Lets copy ourselves into the installation
    cp(rel('../'), userHomePathDotfiles)

    chroot(f'{userHome}/dotfiles/dotfiles.sh --post_install_arch --user {user} --script {script}')
  except Exception as e:
    raise Exception(f'Failed to run the script: {script} - {e}')

def getFileContents(file):
  with open(file, 'r') as f:
    return f.read()

def writeFileContent(file, content):
  with open(file, 'w') as f:
    f.write(content)

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
  partedDisk(f'mkpart primary fat32 {UEFI_FROM}MiB {UEFI_TO}MiB')
  partedDisk('set 1 esp on')
  partedDisk(f'mkpart primary linux-swap {SWAP_SIZE_FROM}MiB {SWAP_SIZE_TO}MiB')
  partedDisk(f'mkpart primary ext4 {SWAP_SIZE_TO}MiB 100%')

  cprint('The final partition is as follows:')
  partedDisk('print')
  input('Press enter to continue...')

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
  cp(rel('various-files/mirrorlist'), '/etc/pacman.d/mirrorlist')

  # Install essential packages
  cprint('Installing essentials')
  cmd('pacstrap /mnt base base-devel linux linux-firmware neovim dhcpcd man-db man-pages intel-ucode grub efibootmgr fish git python python-pip cmake xz pigz')

def generateFStab():
  cprint('Generating fstab')
  writeFileContent('/mnt/etc/fstab', run('genfstab -U /mnt').stdout)

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

  # Fix networking
  cpFromVariousToEtc('hostname')
  cpFromVariousToEtc('hosts')
  chroot('systemctl enable dhcpcd')

def setupUsers(user):
  cprint('Change root password')
  chroot('passwd')

  chroot(f'useradd -m -G wheel -s /usr/bin/fish {user}')
  cprint('Password for the new user:')
  chroot(f'passwd {user}')

  sudoers = '/mnt/etc/sudoers'
  contentToWrite = getFileContents(sudoers).replace('# %wheel ALL=(ALL) ALL', '%wheel ALL=(ALL) ALL').replace('root ALL=(ALL) ALL\n', f'root ALL=(ALL) ALL\n{user} ALL=(ALL) ALL\n')

  writeFileContent(sudoers, contentToWrite)

def enableMultiLibs():
  cprint('Enabling multilibs')
  pacmanConf = '/mnt/etc/pacman.conf'
  contentToWrite = getFileContents(pacmanConf).replace('#[multilib]\n#Include = /etc/pacman.d/mirrorlist', '[multilib]\nInclude = /etc/pacman.d/mirrorlist')

  writeFileContent(pacmanConf, contentToWrite)

def installGrub():
  cprint('Installing grub')
  chroot('grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB')
  chroot('grub-mkconfig -o /boot/grub/grub.cfg')

def install():
  user = input('Which user shall I install as: ')
  # Locale and clock syncing
  cmd('loadkeys sv-latin1')
  cmd('timedatectl set-ntp true')

  diskSetup()
  initIntoMnt()
  generateFStab()
  setupNewSystem()
  setupUsers(user)
  installGrub()
  enableMultiLibs()
  runScript('post-install.sh', user)
  cprint('DONE!')
