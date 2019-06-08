#!/bin/bash

cp ~/.vimrc ~/.dotfiles/vimrc_bu
cp ~/.bash_aliases ~/.dotfiles/bash_aliases_bu
cp ~/.bash_profile ~/.dotfiles/bash_profile_bu
cp ~/.bashrc ~/.dotfiles/bashrc_bu

rm ~/.vimrc && ln -s ~/.dotfiles/vimrc ~/.vimrc
rm ~/.bash_aliases && ln -s ~/.dotfiles/bash_aliases ~/.bash_aliases
rm ~/.bash_profile && ln -s ~/.dotfiles/bash_profile ~/.bash_profile
rm ~/.bashrc && ln -s ~/.dotfiles/bashrc ~/.bashrc

source bash_aliases
source bash_profile
source bashrc