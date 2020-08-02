#!/bin/zsh

# ------------------------ Development Tools ------------------------

# java
pacman -S --noconfirm jdk-openjdk maven intellij-idea-community-edition

#python
pacman -S --noconfirm python-pip

#golang
pacman -S --noconfirm go

# user-setup
declare -a user_commands
user_commands=(
'# python dev packages'
'pip install jedi pylint --user'
''
'# go dev packages'
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
''
'#rust'
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
  echo "$task" >> setup_user.zsh
done