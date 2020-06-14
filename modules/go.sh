#!/bin/bash

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

pacman -S --noconfirm go

#------user------

cat << 'EOT' >> setup_user.sh

echo "Installing go packages"
mkdir -p ~/.go
export GOPATH=~/.go
go get -v github.com/klauspost/asmfmt/cmd/asmfmt
go get -v github.com/go-delve/delve/cmd/dlv
go get -v github.com/kisielk/errcheck
go get -v github.com/davidrjenni/reftools/cmd/fillstruct
go get -v github.com/mdempsky/gocode
go get -v github.com/stamblerre/gocode
go get -v github.com/rogpeppe/godef
go get -v github.com/zmb3/gogetdoc
go get -v golang.org/x/tools/cmd/goimports
go get -v golang.org/x/lint/golint
go get -v golang.org/x/tools/gopls
go get -v github.com/golangci/golangci-lint/cmd/golangci-lint
go get -v github.com/fatih/gomodifytags
go get -v golang.org/x/tools/cmd/gorename
go get -v github.com/jstemmer/gotags
go get -v golang.org/x/tools/cmd/guru
go get -v github.com/josharian/impl
go get -v honnef.co/go/tools/cmd/keyify
go get -v github.com/fatih/motion
go get -v github.com/koron/iferr

EOT
