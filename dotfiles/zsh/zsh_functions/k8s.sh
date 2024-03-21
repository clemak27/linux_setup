#!/bin/bash

function kj() { kubectl "$@" -o json | jq; }
compdef kj=kubectl
function ky() { kubectl "$@" -o yaml | bat -p -P --language=yaml; }
compdef ky=kubectl
function wk() { viddy --no-title kubecolor --force-colors "$@"; }
compdef wk=kubectl
