#!/bin/bash

# https://stackoverflow.com/questions/33725639/npm-install-g-less-does-not-work
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'

echo "" >> ~/.bashrc
echo "# fix npm global requiring sudo" >> ~/.bashrc
echo "export PATH=~/.npm-global/bin:$PATH" >> ~/.bashrc
source ~/.bashrc
