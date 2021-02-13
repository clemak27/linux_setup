#!/bin/zsh

local user=$USER

# glab
mkdir /home/$user/.oh-my-zsh/custom/plugins/glab
echo "compdef _glab glab\ncompdef _glab _glab" > /home/$user/.oh-my-zsh/custom/plugins/glab/glab.plugin.zsh
glab completion -s zsh > /home/$user/.oh-my-zsh/custom/plugins/glab/_glab
sed -i '1 s/^.*$/#compdef glab/' /home/$user/.oh-my-zsh/custom/plugins/glab/_glab
mkdir -p /home/$user/.config/glab-cli

# spotify tui autocompletions
mkdir /home/$user/.oh-my-zsh/custom/plugins/spt
echo "compdef _spt spt" > /home/$user/.oh-my-zsh/custom/plugins/spt/spt.plugin.zsh
spt --completions zsh > /home/$user/.oh-my-zsh/custom/plugins/spt/_spt
