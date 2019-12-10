#!/bin/bash

# export config
cp ../dotfiles/zshrc ~/.zshrc
cp ../dotfiles/vimrc ~/.config/nvim/init.vim
mkdir -p ~/.config/nvim/colors
cp ../dotfiles/ksweet.vim ~/.config/nvim/colors/ksweet.vim

# TODO dont hardcode this xD
# cp ../ff/chrome/* ~/.mozilla/firefox/zfn1qc4b.default-release/chrome/
