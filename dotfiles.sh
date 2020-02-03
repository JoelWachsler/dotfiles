#!/usr/bin/env python

import argparse
import mutil
from glob import glob
from arch_post_install import install as post_install
import importlib
import os

DIR_PATH = os.path.dirname(os.path.realpath(__file__))

class InstallScript:
  def __init__(self, name, script):
    self.name = name.replace('/', '')
    self.script = script
  
  def isPythonScript(self):
    return self.script.endswith('.py')

  def run(self):
    if self.isPythonScript():
      mod = importlib.import_module(self.name + '.install')
      mod.install()
    else:
      mutil.cmd(f'./{self.name}/{self.script}')

def dirIsInstallDir(dir):
  return mutil.exists(f'{dir}/install.sh') or mutil.exists(f'{dir}/install.py')

def main():
  os.chdir(DIR_PATH)

  parser = argparse.ArgumentParser(description='The entrypoint for installing various configuration files according to my preferences.')

  installEntries = []
  for dir in glob(f'**/'):
    if mutil.exists(f'{dir}/install.sh'):
      installEntries.append(InstallScript(dir, 'install.sh'))
    elif mutil.exists(f'{dir}/install.py'):
      installEntries.append(InstallScript(dir, 'install.py'))

  for entry in installEntries:
    parser.add_argument(f'--{entry.name}', dest=f'{entry.name}', action='store_true', default=False)

  parser.add_argument('--user', help='The user to install as if running post install arch script')
  parser.add_argument('--script', help='The script to run if running the post install arch script')
  parser.add_argument('--everything', help='Install everything (except installing arch and post-install)', action='store_true', default=False)

  args = parser.parse_args()

  if args.everything:
    for entry in installEntries:
      if entry.name != 'arch' and entry.name != 'arch_post_install':
        entry.run()
  elif args.arch_post_install:
    user = args.user
    script = args.script

    if user == None or script == None:
      raise Exception('User and script must be defined in order to run post install scripts')

    post_install.install(user, script)
  else:
    argsAsVars = vars(args)
    for entry in installEntries:
      val = argsAsVars[entry.name]
      if val:
        entry.run()

if __name__ == "__main__":
  main()
