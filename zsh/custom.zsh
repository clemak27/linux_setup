#!/bin/zsh

function glab_issue_description {
  uuid=$(uuidgen)
  glab issue view 73 > $uuid.md
  tail $uuid.md --lines=+8 > $uuid.md
  nvim $uuid.md
  glab issue update 73 --description "$(cat -p $uuid.md)"
  rm $uuid.md
}
