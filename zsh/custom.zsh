#!/bin/zsh

function glab_issue_description {
  if [ "$#" -ne 1 ]; then
    echo "missing issue number!"
    return 1
  fi

  issue_number="$1"

  glab issue view $issue_number &> /dev/null
  if [ $? -ne 0 ]; then
    echo "gitlab issue not found!"
    return 1
  fi

  uuid=$(uuidgen)
  glab issue view $issue_number > $uuid.md
  desc=$(tail $uuid.md --lines=+8)
  echo $desc > $uuid.md
  nvim $uuid.md
  glab issue update $issue_number --description "$(bat -p $uuid.md)"

  rm $uuid.md
  unset uuid
  unset desc
}
