#!/bin/sh

curl -O -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x nvim.appimage
mv nvim.appimage ~/Projects/linux_setup/other/nvim.appimage
