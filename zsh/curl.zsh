#!/bin/zsh

function jcurl {
  curl --no-progress-meter $@ | jq '.'
}

