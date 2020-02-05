import json, os
from mutil import cmd

HOME = os.environ['HOME']

def writeFileContents(file, contents):
  with open(file, 'w') as f:
    f.write(contents)

def getFileContents(file):
  with open(file, 'r') as f:
    return f.read()

def updateProfile():
  profileLocation = f'{HOME}/.profile'
  writeFileContents(profileLocation, 'setxkbmap -layout se -option nodeadkeys,caps:escape')

def updateAutokeyFolders():
  fileLocation = f'{HOME}/.config/autokey/autokey.json'
  content = getFileContents(fileLocation)
  jsonContent = json.loads(content)
  jsonContent['folders'] = f'{HOME}/dotfiles/keymap/my-rebings'
  resultingContent = json.dumps(jsonContent, indent=4)
  writeFileContents(resultingContent)

def install():
  print('--- Fixing keyboard ---')
  updateProfile()
  updateAutokeyFolders()