#!/bin/sh

msg_title="NixOS Update"
flake_dir="$HOME/.linux_setup"
lockfile="$flake_dir/flake.lock"

nixpkgs_current=""
nixpkgs_updated=""

log_msg() {
  echo "[$msg_title] $1"
}

update_flatpak() {
  log_msg "[flatpak] Updating"
  fMsg=$(flatpak update -y)

  if echo "$fMsg" | grep "Nothing to do" > /dev/null; then
    log_msg "[flatpak] Already up to date."
  fi
}

record_state() {
  nixpkgs_current=$(jq '.nodes.nixpkgs.locked.lastModified' < "$lockfile")
}

pull_latest() {
  log_msg "[git] Updating repo"
  if ! git -C "$flake_dir" pull --rebase; then
    log_msg "[git] Failed to update repo, cancelling"
    exit 1
  fi

  log_msg "[git] Done."
  nixpkgs_updated=$(jq '.nodes.nixpkgs.locked.lastModified' < "$lockfile")
}

check_nixpkgs() {
  if [ "$nixpkgs_current" = "$nixpkgs_updated" ]; then
    log_msg "[nixpkgs] No activation needed"
    log_msg "Finished Autoupdate"
    exit 221
  fi
  log_msg "[nixpkgs] Updated."
}

log_msg "Starting Autoupdate"
update_flatpak
record_state
pull_latest
check_nixpkgs
log_msg "Finished Autoupdate"
