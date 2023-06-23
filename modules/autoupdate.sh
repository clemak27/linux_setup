#!/bin/sh

msg_title="NixOS Update"
flake_dir="$HOME/Projects/linux_setup"
lockfile="$flake_dir/flake.lock"

msg_id=""
nixpkgs_current=""
nixpkgs_updated=""
homecfg_current=""
homecfg_updated=""
lazy_current=""
lazy_updated=""

send_message() {
  if [ "$msg_id" = "" ]; then
    msg_id=$(notify-send -p "$msg_title" "$1")
    echo "[$msg_title] $1"
    sleep 1
  else
    notify-send -r "$msg_id" "$msg_title" "$1"
    echo "[$msg_title] $1"
    sleep 1
  fi
}

record_state() {
  nixpkgs_current=$(jq '.nodes.nixpkgs.locked.lastModified' < "$lockfile")
  homecfg_current=$(jq '.nodes.homecfg.locked.lastModified' < "$lockfile")
  lazy_current=$(sha256sum "$flake_dir/dotfiles/lazy-lock.json" | awk '{print $1}')
}

pull_latest() {
  send_message "[git] Updating repo"
  if [ "master" != "$(git -C "$flake_dir" rev-parse --abbrev-ref HEAD)" ]; then
    send_message "[git] Not on master branch, cancelling"
    exit 1
  fi

  if ! git -C "$flake_dir" pull --rebase; then
    send_message "[git] Failed to update repo, cancelling"
    exit 1
  else
    send_message "[git] Done."
    nixpkgs_updated=$(jq '.nodes.nixpkgs.locked.lastModified' < "$lockfile")
    homecfg_updated=$(jq '.nodes.homecfg.locked.lastModified' < "$lockfile")
  fi
}

update_flatpak() {
  send_message "[flatpak] Updating"
  fMsg=$(flatpak update -y)

  if echo "$fMsg" | grep "Nothing to do" > /dev/null; then
    send_message "[flatpak] Already up to date."
  fi
}

update_homecfg_nvim() {
  if [ "$homecfg_current" != "$homecfg_updated" ]; then
    send_message "[homecfg] Updated. Reloading home-manger"
    home-manager switch --flake "$flake_dir" --impure
    lazy_updated=$(sha256sum "$flake_dir/dotfiles/lazy-lock.json" | awk '{print $1}')
    if [ "$lazy_current" != "$lazy_updated" ]; then
      send_message "[nvim.lazy] Restoring."
      nvim tmpfile +"lua require('lazy').restore({wait=true}); vim.cmd('qa!')"
    else
      send_message "[nvim.lazy] Nothing to do."
    fi
  else
    nix flake lock --update-input homecfg "$flake_dir"
    homecfg_updated=$(jq '.nodes.homecfg.locked.lastModified' < "$lockfile")
    if [ "$homecfg_current" != "$homecfg_updated" ]; then
      send_message "[homecfg] Updated. Reloading home-manger"
      git -C "$flake_dir" add "$flake_dir"/flake.lock
      git -C "$flake_dir" commit -v -m "chore: update homecfg"
      home-manager switch --flake "$flake_dir" --impure
      send_message "[nvim.lazy] Updating."
      nvim tmpfile +"lua require('lazy').sync({wait=true}); vim.cmd('qa!')"
      git -C "$flake_dir" add "$flake_dir"/dotfiles/lazy-lock.json
      git -C "$flake_dir" commit -v -m "chore: update lazy-lock"
    else
      send_message "[homecfg] Nothing to do."
    fi
  fi
}

check_nixpkgs() {
  if [ "$nixpkgs_current" = "$nixpkgs_updated" ]; then
    send_message "[nixpkgs] No activation needed"
    send_message "Finished Autoupdate"
    exit 221
  fi
  send_message "[nixpkgs] Updated. Will activate"
}

sleep 30

send_message "Starting Autoupdate"
update_flatpak
record_state
pull_latest
update_homecfg_nvim
check_nixpkgs
send_message "Finished Autoupdate"
