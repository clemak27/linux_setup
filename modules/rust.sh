#!/bin/bash

echo "Rust will be installed as part of user-setup!"

#------user------

cat <<EOT >> setup_user.sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
EOT
