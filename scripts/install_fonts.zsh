#!/bin/zsh

mkdir font
cd font

curl -L -O https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
unzip JetBrainsMono.zip

mkdir jbm
cp *Complete.ttf jbm

rm jbm/JetBrains\ Mono\ Medium\ Med\ Ita\ Nerd\ Font\ Complete.ttf
rm jbm/JetBrains\ Mono\ Medium\ Medium\ Nerd\ Font\ Complete.ttf
rm jbm/JetBrains\ Mono\ ExtraBold\ ExtBd\ Nerd\ Font\ Complete.ttf
rm jbm/JetBrains\ Mono\ ExtraBold\ ExBd\ I\ Nerd\ Font\ Complete.ttf

cp -R jbm ~/.fonts

cd ..
rm -rf font
