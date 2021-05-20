#!/bin/zsh

local user=$USER

# glab
mkdir /home/$user/.oh-my-zsh/custom/plugins/glab
echo "compdef _glab glab\ncompdef _glab _glab" > /home/$user/.oh-my-zsh/custom/plugins/glab/glab.plugin.zsh
glab completion -s zsh > /home/$user/.oh-my-zsh/custom/plugins/glab/_glab
sed -i '1 s/^.*$/#compdef glab/' /home/$user/.oh-my-zsh/custom/plugins/glab/_glab
mkdir -p /home/$user/.config/glab-cli

# gradle
git clone git://github.com/gradle/gradle-completion /home/$user/.oh-my-zsh/custom/plugins/gradle-completion

# tea
mkdir /home/$user/.oh-my-zsh/custom/plugins/tea
tea shellcompletion zsh
mv /home/$user/.config/tea/autocomplete.zsh /home/$user/.oh-my-zsh/custom/plugins/tea
echo "PROG=tea _CLI_ZSH_AUTOCOMPLETE_HACK=1 source ~/.oh-my-zsh/custom/plugins/tea/autocomplete.zsh" > /home/$user/.oh-my-zsh/custom/plugins/tea/tea.plugin.zsh
