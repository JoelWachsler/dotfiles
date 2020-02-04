import subprocess, os, shutil

def expand(command):
  return os.path.expandvars(command)

def cmd(command):
  return subprocess.check_call(expand(command), shell=True)

def run(command):
  return subprocess.run(command, stdout=subprocess.PIPE, universal_newlines=True, shell=True)

def cp(fromFile, toFile):
  if os.path.isfile(fromFile):
    return shutil.copy(fromFile, toFile)
  else:
    return shutil.copytree(fromFile, toFile)

def rm(file):
  if os.path.exists(file):
    shutil.rmtree(file)

def exists(file):
  return os.path.exists(file)
