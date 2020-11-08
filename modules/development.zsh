#!/bin/zsh

# ------------------------ Development Tools ------------------------

# java
pacman -S --noconfirm jdk-openjdk maven intellij-idea-community-edition

#python
pacman -S --noconfirm python-pip

# ------------------------ AUR ------------------------

# setup

cd /
mkdir /home/aurBuilder
chgrp nobody /home/aurBuilder
chmod g+ws /home/aurBuilder
setfacl -m u::rwx,g::rwx /home/aurBuilder
setfacl -d --set u::rwx,g::rwx,o::- /home/aurBuilder
usermod -d /home/aurBuilder nobody
echo '%nobody ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
cd /home/aurBuilder

# install packages

declare -a aur_packages
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

aur_packages=(
  'insomnia-bin'
)

declare -r aur_packages
IFS=$SAVEIFS

for package in "${aur_packages[@]}"
do
  git clone https://aur.archlinux.org/$package.git
  chmod -R g+w $package
  cd $package
  sudo -u nobody makepkg -sri --noconfirm
  cd ..
done

# cleanup

sed -i '$d' /etc/sudoers
cd /linux_setup
usermod -d / nobody
rm -rf /home/aurBuilder

# ------------------------ user ------------------------


# user-setup
declare -a user_commands
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
user_commands=(
  # python dev packages
  'pip install jedi pylint --user'
  # rust
  'curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path'
)
declare -r user_commands
IFS=$SAVEIFS

for task in "${user_commands[@]}"
do
  su - $user -c $task
done

# ------------------------ notes ------------------------