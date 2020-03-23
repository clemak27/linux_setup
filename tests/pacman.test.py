#!/bin/python3

import subprocess

packages = []
fails = []

for line in open('./setup_system.sh'):
    if 'pacman -S --noconfirm' in line:
        packagesInLine = line.replace('pacman -S --noconfirm ', '').replace('\n','')
        packaP = packagesInLine.split(' ')
        for package in packaP:
            packages.append(package)

print("Checking availability of", len(packages), "packages.")

for package in packages:
    searchTerm = '^'+package+'$'
    result = subprocess.run(['pacman', '-Ss', searchTerm], stdout=subprocess.PIPE).stdout.decode('utf-8')
    if not result:
        print('oh no')
        fails.append(package)

if len(fails) > 0:
    print("Test failed;", len(fails) , "packages not found:")
    print(fails)
    raise AssertionError()
else:
    print("Test successful, all packages found.")
