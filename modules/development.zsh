#!/bin/zsh

# ------------------------ Development Tools ------------------------

# java
pacman -S --noconfirm jdk-openjdk maven intellij-idea-community-edition

#python
pacman -S --noconfirm python-pip

#golang
pacman -S --noconfirm go


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
  # go dev packages
  'mkdir -p ~/.go'
  'export GOPATH=~/.go'
  'go get -v github.com/klauspost/asmfmt/cmd/asmfmt'
  'go get -v github.com/go-delve/delve/cmd/dlv'
  'go get -v github.com/kisielk/errcheck'
  'go get -v github.com/davidrjenni/reftools/cmd/fillstruct'
  'go get -v github.com/mdempsky/gocode'
  'go get -v github.com/stamblerre/gocode'
  'go get -v github.com/rogpeppe/godef'
  'go get -v github.com/zmb3/gogetdoc'
  'go get -v golang.org/x/tools/cmd/goimports'
  'go get -v golang.org/x/lint/golint'
  'go get -v golang.org/x/tools/gopls'
  'go get -v github.com/golangci/golangci-lint/cmd/golangci-lint'
  'go get -v github.com/fatih/gomodifytags'
  'go get -v golang.org/x/tools/cmd/gorename'
  'go get -v github.com/jstemmer/gotags'
  'go get -v golang.org/x/tools/cmd/guru'
  'go get -v github.com/josharian/impl'
  'go get -v honnef.co/go/tools/cmd/keyify'
  'go get -v github.com/fatih/motion'
  'go get -v github.com/koron/iferr'
  # rust
  'curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh'
  ''
  '# rust path is set in .zshrc already, use these options'
  '# default host triple: x86_64-unknown-linux-gnu'
  '# default toolchain: stable'
  '# profile: default'
  '# modify PATH variable: no'
)
declare -r user_commands
IFS=$SAVEIFS

for task in "${user_commands[@]}"
do
  su - $user -c $task
done

# ------------------------ notes ------------------------