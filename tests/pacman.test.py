#!/bin/python3

import subprocess
from os import listdir
from os.path import isfile, join
import json

packages = []
ignored = ['lib32-nvidia-utils', 'lib32-vulkan-icd-loader', 'wine-staging', 'steam', '', 'lib32-gamemode']
fails = []
modulePath = './setup/modules.json'

if isfile(modulePath):
    modJson = json.loads(open(modulePath))
    for pkg in modJson:
        packages.append(pkg["packages"])

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
