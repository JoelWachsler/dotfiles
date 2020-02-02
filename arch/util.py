import subprocess, os, shutil

def expand(command):
  return os.path.expandvars(command)

def cmd(command):
  return subprocess.call(expand(command), shell=True)

def run(command):
  return subprocess.run(command, stdout=subprocess.PIPE, universal_newlines=True, shell=True)

def cp(fromFile, toFile):
  return shutil.copy(fromFile, toFile)

def rm(file):
  os.remove(file)

