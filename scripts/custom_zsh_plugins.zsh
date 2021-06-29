#!/bin/zsh

local user=$USER

# gradle
git clone git://github.com/gradle/gradle-completion /home/$user/.oh-my-zsh/custom/plugins/gradle-completion

# tea
mkdir /home/$user/.oh-my-zsh/custom/plugins/tea
tea shellcompletion zsh
mv /home/$user/.config/tea/autocomplete.zsh /home/$user/.oh-my-zsh/custom/plugins/tea
echo "PROG=tea _CLI_ZSH_AUTOCOMPLETE_HACK=1 source ~/.oh-my-zsh/custom/plugins/tea/autocomplete.zsh" > /home/$user/.oh-my-zsh/custom/plugins/tea/tea.plugin.zsh
