import subprocess, os, shutil

def expand(command):
  return os.path.expandvars(command)

def cmd(command):
  return subprocess.check_call(expand(command), shell=True)

def run(command):
  return subprocess.run(expand(command), stdout=subprocess.PIPE, universal_newlines=True, shell=True)

def ln(fromFile, toFile):
  return os.symlink(expand(fromFile), expand(toFile))

def isFile(file):
  return os.path.isfile(expand(file))

def copyFile(fromFile, toFile):
  return shutil.copy(expand(fromFile), expand(toFile))

def copyDir(fromFile, toFile):
  return shutil.copytree(expand(fromFile), expand(toFile))

def cp(fromFile, toFile):
  if isFile(fromFile):
    return copyFile(fromFile, toFile)
  else:
    return copyDir(fromFile, toFile)

def rm(file):
  if exists(file):
    shutil.rmtree(expand(file))

def exists(file):
  return os.path.exists(expand(file))

def getFileContents(file):
  with open(expand(file), 'r') as f:
    return f.read()

def writeFileContent(file, content):
  with open(expand(file), 'w') as f:
    f.write(content)
