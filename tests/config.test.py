#!/bin/python3

import subprocess
import fileinput
from os import listdir
from os.path import isfile, join

setupPath = './setup_system.zsh'
configPath = './config.zsh'
fails = 0

def checkReplacement(original, replacement):
    for line in fileinput.input(configPath, inplace = 1):
        print(line.replace(original, replacement).rstrip())

    result = subprocess.run(['sh', setupPath], stdout=subprocess.PIPE)
    rc = result.returncode
    if rc != 1:
        fails = fails + 1

    for line in fileinput.input(configPath, inplace = 1):
          print(line.replace(replacement, original).rstrip())


print("Checking config tests:")

with open(configPath, "a") as cFile:
    cFile.write("\nexit 0")

checkReplacement('device="/dev/nvme0n1"', 'device=""')
checkReplacement('passphrase="abcd"', 'passphrase=""')
checkReplacement('luksMapper="cryptroot"', 'luksMapper=""')
checkReplacement('volumeGroup="vg1"', 'volumeGroup=""')
checkReplacement('hostname="lazarus"', 'hostname=""')
checkReplacement('user="clemens"', 'user=""')
checkReplacement('password="1234"', 'password=""')
checkReplacement('cpu="amd"', 'cpu=""')
checkReplacement('cpu="amd"', 'cpu="aaaaaaaa"')
checkReplacement('gpu="nvidia"', 'gpu=""')

if fails > 0:
    print("Test failed!")
    raise AssertionError()
else:
    print("Test successful!")
