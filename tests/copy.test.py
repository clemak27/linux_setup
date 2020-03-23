#!/bin/python3

import os.path

commands = []
fails = []

def scanFile(filepath):
    for line in open(filepath):
        if 'cp ' in line:
            packagesInLine = line.replace('cp ', '').replace('\n','')
            commandPaths = packagesInLine.split(' ')
            commands.append(commandPaths[0])

print("Checking if all files that should be copied exist.")

scanFile('./setup_arch.sh')
scanFile('./setup_system.sh')
scanFile('./setup_user.sh')

for filePath in commands:
    if not os.path.exists(filePath):
        fails.append(filePath)

if len(fails) > 0:
    print("Test failed:", len(fails) , "files not found:")
    print(fails)
    raise AssertionError()
else:
    print("Test successful, all files to copy found.")
