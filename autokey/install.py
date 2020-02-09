import json, os
from mutil import cmd, getFileContents, writeFileContent

HOME = os.environ['HOME']

def updateAutokeyFolders():
  fileDir = f'{HOME}/.config/autokey'
  fileLocation = f'{fileDir}/autokey.json'
  cmd(f'mkdir -p {fileDir}')
  content = getFileContents(fileLocation)
  jsonContent = json.loads(content)
  jsonContent['folders'] = [f'{HOME}/dotfiles/autokey/my-rebinds']
  resultingContent = json.dumps(jsonContent, indent=4)
  writeFileContents(fileLocation, resultingContent)

def doc():
  return 'Adds autokey configuration files to the config directory'

def install():
  updateAutokeyFolders()