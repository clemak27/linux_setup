#!/bin/bash

echo "Rust will be installed as part of user-setup!"

#------user------

cat << 'EOT' >> setup_user.sh

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# rust path is set in zshrc already, use these options
# default host triple: x86_64-unknown-linux-gnu
# default toolchain: stable
# profile: default
# modify PATH variable: no

EOT
