#!/bin/bash

# export config
cp ../dotfiles/zshrc /home/cle/.zshrc
cp ../dotfiles/vimrc /home/cle/.config/nvim/init.vim
mkdir -p /home/cle/.config/nvim/colors
cp ../dotfiles/ksweet.vim /home/cle/.config/nvim/colors/ksweet.vim

# TODO dont hardcode this xD
# cp ../ff/chrome/* /home/cle/.mozilla/firefox/zfn1qc4b.default-release/chrome/
