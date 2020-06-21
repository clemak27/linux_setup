#!/bin/python3

import subprocess
from os import listdir
from os.path import isfile, join

fails = []
modulePath = './modules'

for file in listdir(modulePath):
    if isfile(join(modulePath, file)) and "_user" not in file:
        for line in open(join(modulePath, file)):
            if '~' in line:
                fails.append( "Found ~ in " + file + "in line :" + line)

if len(fails) > 0:
    print("Test failed:", len(fails) , "~ symbols found:")
    print(fails)
    raise AssertionError()
else:
    print("No unexpected characters found.")
