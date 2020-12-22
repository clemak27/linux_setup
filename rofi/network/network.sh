#!/usr/bin/env bash

rofi_path=$HOME/Projects/linux_setup/rofi

rofi_command="rofi -theme $rofi_path/network/network.rasi"

## Get info
IFACE="$(nmcli | grep -i interface | awk '/interface/ {print $2}')"
#SSID="$(iwgetid -r)"
#LIP="$(nmcli | grep -i server | awk '/server/ {print $2}')"
#PIP="$(dig +short myip.opendns.com @resolver1.opendns.com )"
STATUS="$(nmcli radio wifi)"

active=""
urgent=""

if (ping -c 1 archlinux.org || ping -c 1 google.com || ping -c 1 bitbucket.org || ping -c 1 github.com || ping -c 1 sourceforge.net) &>/dev/null; then
  if [[ $STATUS == *"enable"* ]]; then
    if [[ $IFACE == e* ]]; then
      connected="ethernet"
    else
      connected="直"
    fi
    active="-a 0"
    SSID="﬉ $(iwgetid -r)"
    PIP="$(wget --timeout=30 http://ipinfo.io/ip -qO -)"
  fi
else
  urgent="-u 0"
  SSID="Disconnected"
  PIP="Not Available"
  connected="睊"
fi

## Icons
bmon=""
launch_cli="漣"
launch=""

options="$connected\n$bmon\n$launch_cli\n$launch"

## Main
chosen="$(echo -e "$options" | $rofi_command -p "$SSID" -dmenu $active $urgent -selected-row 1)"
case $chosen in
  $connected)
    if [[ $STATUS == *"enable"* ]]; then
      nmcli radio wifi off
    else
      nmcli radio wifi on
    fi
    ;;
  $bmon)
    kitty bmon
    ;;
  $launch_cli)
    kitty nmtui
    ;;
  $launch)
    nm-connection-editor
    ;;
esac

