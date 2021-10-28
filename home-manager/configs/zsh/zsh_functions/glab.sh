#!/bin/sh

function glab_issue_description {
  if [ "$#" -ne 1 ]; then
    echo "missing issue number!"
    return 1
  fi

  local issue_number="$1"

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

function glab_mr_description {

  local mr_number="$1"

  glab mr view $mr_number &> /dev/null
  if [ $? -ne 0 ]; then
    $mr_number=""
  fi

  uuid=$(uuidgen)
  glab mr view $mr_number > $uuid.md
  desc=$(tail $uuid.md --lines=+10)
  echo $desc > $uuid.md
  nvim $uuid.md
  glab mr update $mr_number --description "$(bat -p $uuid.md)"

  rm $uuid.md
  unset uuid
  unset desc
}
