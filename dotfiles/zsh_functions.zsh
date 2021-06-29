#!/bin/zsh

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
