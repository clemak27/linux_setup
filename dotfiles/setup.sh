#!/bin/bash

cp ~/.vimrc ~/.dotfiles/vimrc_bu
cp ~/.bash_aliases ~/.dotfiles/bash_aliases_bu
cp ~/.bash_profile ~/.dotfiles/bash_profile_bu
cp ~/.bashrc ~/.dotfiles/bashrc_bu

cp vimrc ~/.vimrc
cp bash_aliases ~/.bash_aliases
cp bash_profile ~/.bash_profile
cp bashrc ~/.bashrc

source bash_aliases
source bash_profile
source bashrc