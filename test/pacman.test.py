#!/bin/python3

import subprocess
from os.path import isfile
import json

packages = []
ignored = ['lib32-nvidia-utils', 'lib32-vulkan-icd-loader', 'wine-staging', 'steam', '', 'lib32-gamemode']
fails = []
modulePath = './setup/modules.json'

if isfile(modulePath):
    modJson = json.load(open(modulePath))
    for mod in modJson["modules"]:
        for pkg in mod["packages"]:
            packages.append(pkg)

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
