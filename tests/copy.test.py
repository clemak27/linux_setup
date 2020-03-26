#!/bin/python3

import os.path
from os import listdir
from os.path import isfile, join

commands = []
ignored = ['/usr/share/doc/mpv/']
fails = []
modulePath = './modules'

def scanFile(filepath):
    for line in open(filepath):
        if 'cp ' in line:
            packagesInLine = line.replace('cp -R ', '').replace('cp -r ', '').replace('cp ', '').replace('\n','')
            commandPaths = packagesInLine.split(' ')
            commands.append(commandPaths[0])

print("Checking if all files that should be copied exist.")

scanFile('./setup_arch.sh')
scanFile('./setup_user.sh')

for file in listdir(modulePath):
    if isfile(join(modulePath, file)):
        scanFile(join(modulePath, file))

for filePath in commands:
    if not os.path.exists(filePath) and filePath not in ignored:
        fails.append(filePath)

if len(fails) > 0:
    print("Test failed:", len(fails) , "files not found:")
    print(fails)
    raise AssertionError()
else:
    print("Test successful, all files to copy found.")
