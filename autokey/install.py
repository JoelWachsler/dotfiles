import json, os
from mutil import cmd

HOME = os.environ['HOME']

def writeFileContents(file, contents):
  with open(file, 'w') as f:
    f.write(contents)

def getFileContents(file):
  with open(file, 'r') as f:
    return f.read()

def updateAutokeyFolders():
  fileDir = f'{HOME}/.config/autokey'
  fileLocation = f'{fileDir}/autokey.json'
  cmd(f'mkdir -p {fileDir}')
  content = getFileContents(fileLocation)
  jsonContent = json.loads(content)
  jsonContent['folders'] = f'{HOME}/dotfiles/autokey/my-rebinds'
  resultingContent = json.dumps(jsonContent, indent=4)
  writeFileContents(resultingContent)

def install():
  updateAutokeyFolders()