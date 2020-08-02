#!/bin/zsh

set -uo pipefail
trap 's=$?; echo "$0: Error on line "$LINENO": $BASH_COMMAND"; exit $s' ERR

# Load config
if [ -f ./config.zsh ]; then
    source ./config.zsh
else
   echo "Config file could not be found!"
   exit 1
fi

for module in "${system_modules[@]}"
do
  echo "Setting up module "$module
  for task in "${setup_commands[$module][@]}"
  do
    /bin/zsh -i -c $task
  done
  for task in "${user_commands[$module][@]}"
  do
    echo "$task" >> setup_user.zsh
  done
done