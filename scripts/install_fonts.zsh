#!/bin/zsh

cd ~/Projects

mkdir jbm
cd jbm
curl -L -O https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
unzip JetBrainsMono.zip
mkdir fonts
cp *Mono.ttf fonts
rm fonts/JetBrains\ Mono\ Medium\ Med\ Ita\ Nerd\ Font\ Complete Mono.ttf
rm fonts/JetBrains\ Mono\ Medium\ Medium\ Nerd\ Font\ Complete\ Mono.ttf
rm fonts/JetBrains\ Mono\ ExtraBold\ ExtBd\ Nerd\ Font\ Complete\ Mono.ttf
rm fonts/JetBrains\ Mono\ ExtraBold\ ExBd\ I\ Nerd\ Font\ Complete Mono.ttf
