#!/bin/sh

msg_title="NixOS Update"
flake_dir="$HOME/Projects/linux_setup"
lockfile="$flake_dir/flake.lock"

nixpkgs_current=""
nixpkgs_updated=""
homecfg_current=""
homecfg_updated=""
lazy_current=""
lazy_updated=""

log_msg() {
  echo "[$msg_title] $1"
}

record_state() {
  nixpkgs_current=$(jq '.nodes.nixpkgs.locked.lastModified' < "$lockfile")
  homecfg_current=$(jq '.nodes.homecfg.locked.lastModified' < "$lockfile")
  lazy_current=$(sha256sum "$flake_dir/dotfiles/lazy-lock.json" | awk '{print $1}')
}

pull_latest() {
  log_msg "[git] Updating repo"
  if [ "master" != "$(git -C "$flake_dir" rev-parse --abbrev-ref HEAD)" ]; then
    log_msg "[git] Not on master branch, cancelling"
    exit 1
  fi

  if ! git -C "$flake_dir" pull --rebase; then
    log_msg "[git] Failed to update repo, cancelling"
    exit 1
  else
    log_msg "[git] Done."
    nixpkgs_updated=$(jq '.nodes.nixpkgs.locked.lastModified' < "$lockfile")
    homecfg_updated=$(jq '.nodes.homecfg.locked.lastModified' < "$lockfile")
  fi
}

update_flatpak() {
  log_msg "[flatpak] Updating"
  fMsg=$(flatpak update -y)

  if echo "$fMsg" | grep "Nothing to do" > /dev/null; then
    log_msg "[flatpak] Already up to date."
  fi
}

update_nvim() {
  lazy_updated=$(sha256sum "$flake_dir/dotfiles/lazy-lock.json" | awk '{print $1}')
  if [ "$lazy_current" != "$lazy_updated" ]; then
    log_msg "[nvim.lazy] Updated. Restoring."
    nvim tmpfile +"lua require('lazy').restore({wait=true}); vim.cmd('qa!')"
  elif [ "$lazy_current" = "$lazy_updated" ] && [ "$nixpkgs_current" != "$nixpkgs_updated" ]; then
    log_msg "[nvim.lazy] Updating."
    nvim tmpfile +"lua require('lazy').sync({wait=true}); vim.cmd('qa!')"
    git -C "$flake_dir" add "$flake_dir"/dotfiles/lazy-lock.json
    git -C "$flake_dir" commit -v -m "chore: update lazy-lock"
    git -C "$flake_dir" push
  fi
  log_msg "[nvim.lazy] Nothing to do."
}

update_homecfg() {
  if [ "$homecfg_current" != "$homecfg_updated" ]; then
    log_msg "[homecfg] Updated."
    exit 0
  else
    log_msg "[homecfg] Nothing to do."
  fi
}

check_nixpkgs() {
  if [ "$nixpkgs_current" = "$nixpkgs_updated" ]; then
    log_msg "[nixpkgs] No activation needed"
    log_msg "Finished Autoupdate"
    exit 221
  fi
  log_msg "[nixpkgs] Updated."
}

sleep 30

log_msg "Starting Autoupdate"
update_flatpak
record_state
pull_latest
update_nvim
update_homecfg
check_nixpkgs
log_msg "Finished Autoupdate"
