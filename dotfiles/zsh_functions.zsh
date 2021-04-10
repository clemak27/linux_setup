#!/bin/zsh

# --------------------- curl  ---------------------

function jcurl {
  curl --no-progress-meter $@ | jq '.'
}

# --------------------- glab  ---------------------

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

function glab_mr_checkout() {

  local mr_number
  export GITLAB_TOKEN=$(secret-tool lookup glab api)

  mr_number="$(glab api "/projects/:id/merge_requests?state=opened&order_by=created_at&view=simple&scope=all" |
    jq --raw-output '.[] | "\(.iid) - \(.title)"' |
    fzf --ansi --no-multi --preview 'glab mr view {1}' |
    sed 's/^\([0-9]\+\).*/\1/'
  )"

  unset GITLAB_TOKEN

  if [ -n "$mr_number" ]; then
    glab mr checkout "$mr_number"
  fi
}

# --------------------- git+fzf  ---------------------
# https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

function gitfiles() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; bat {-1})' |
  cut -c4- | sed 's/.* -> //'
}

alias gaf='git add $(gitfiles)'

function gitbranches() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf --ansi --no-multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1)' |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

alias gcf='git checkout $(gitbranches)'
