#!/bin/python3

import subprocess

packages = []

for line in open('../setup_system.sh'):
    if 'pacman -S --noconfirm' in line:
        packagesInLine = line.replace('pacman -S --noconfirm ', '').replace('\n','')
        packaP = packagesInLine.split(' ')
        for package in packaP:
            packages.append(package)

print(packages)

for package in packages:
    searchTerm = '^'+package+'-'
    result = subprocess.run(['pacman', '-Ss', searchTerm], stdout=subprocess.PIPE).stdout.decode('utf-8')
    # if not result
    #     print('oh no')
    # else
    #     print('ok')
