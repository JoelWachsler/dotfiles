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

  @property
  def isPythonScript(self):
    return self.script.endswith('.py')
  
  @property
  def documentation(self):
    if self.isPythonScript:
      try:
        return self.pythonInstallScript.doc()
      except Exception as e:
        # There is no documentation for this module
        return ''
    else:
      return ''
  
  @property
  def pythonInstallScript(self):
    return importlib.import_module(self.name + '.install')

  def run(self):
    if self.isPythonScript:
      self.pythonInstallScript.install()
    else:
      mutil.cmd(f'./{self.name}/{self.script}')

def dirIsInstallDir(dir):
  return mutil.exists(f'{dir}/install.sh') or mutil.exists(f'{dir}/install.py')

def main():
  os.chdir(DIR_PATH)

  parser = argparse.ArgumentParser(description='The entrypoint for installing various configuration files and programs according to my preferences.')

  installEntries = []
  for dir in glob(f'**/'):
    if mutil.exists(f'{dir}/install.sh'):
      installEntries.append(InstallScript(dir, 'install.sh'))
    elif mutil.exists(f'{dir}/install.py'):
      installEntries.append(InstallScript(dir, 'install.py'))

  for entry in installEntries:
    parser.add_argument(f'--{entry.name}', help=entry.documentation, dest=f'{entry.name}', action='store_true', default=False)

  specialEntries = ['arch', 'arch_post_install', 'virtualbox_guest', 'autokey', 'configure_kde']
  parser.add_argument('--everything', help=f'Install everything (except: {", ".join(specialEntries)})', action='store_true', default=False)

  args = parser.parse_args()

  if args.everything:
    for entry in installEntries:
      if entry.name not in specialEntries:
        entry.run()
  elif args.arch_post_install:
    post_install.install()
  else:
    argsAsVars = vars(args)
    for entry in installEntries:
      val = argsAsVars[entry.name]
      if val:
        entry.run()

if __name__ == "__main__":
  main()
