#!/bin/python3

import subprocess
from os import listdir
from os.path import isfile, join

packages = []
ignored = ['lib32-nvidia-utils', 'lib32-vulkan-icd-loader', 'wine-staging', 'steam', '']
fails = []
modulePath = './modules'

for file in listdir(modulePath):
    if isfile(join(modulePath, file)):
        for line in open(join(modulePath, file)):
            if 'pacman -S --noconfirm' in line and not line.startswith("  '"):
                packagesInLine = line.replace('pacman -S --noconfirm ', '').replace('\n','')
                packagesInCommand = packagesInLine.split(' ')
                for package in packagesInCommand:
                    packages.append(package)

print("Checking availability of", len(packages)-len(ignored), "packages.")

for package in packages:
    if package not in ignored:
        searchTerm = '^'+package+'$'
        result = subprocess.run(['pacman', '-Ss', searchTerm], stdout=subprocess.PIPE).stdout.decode('utf-8')
        if not result:
            fails.append(package)

if len(fails) > 0:
    print("Test failed:", len(fails) , "packages not found:")
    print(fails)
    raise AssertionError()
else:
    print("Test successful, all packages found.")
