#!/bin/bash

cp ~/.config/nvim/init.vim nvim_bu
cp ~/.bash_aliases bash_aliases_bu
cp ~/.bash_profile bash_profile_bu
cp ~/.bashrc bashrc_bu

mkdir ~/./config/nvim
cp vimrc ~/.config/nvim/init.vim
cp bash_aliases ~/.bash_aliases
cp bash_profile ~/.bash_profile
cp bashrc ~/.bashrc

source bash_aliases
source bash_profile
source bashrc
