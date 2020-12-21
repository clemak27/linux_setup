#!/usr/bin/env bash

rofi_path=$HOME/Projects/linux_setup/rofi

rofi_command="rofi -theme $rofi_path/powermenu/powermenu.rasi"

uptime=$(uptime -p | sed -e 's/up //g')
cpu=$(sh $rofi_path/powermenu/usedcpu)
memory=$(sh $rofi_path/powermenu/usedram)

# Options
shutdown=""
reboot=""
lock=""
suspend="⏾"
logout=""

# Confirmation
confirm_exit() {
  $rofi_path/confirm/confirm.sh
}

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

chosen="$(echo -e "$options" | $rofi_command -p "UP - $uptime" -dmenu -selected-row 2)"
case $chosen in
  $shutdown)
    ans=$(confirm_exit &)
    if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
      systemctl poweroff
    elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
      exit 0
    fi
    ;;
  $reboot)
    ans=$(confirm_exit &)
    if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
      systemctl reboot
    elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
      exit 0
    fi
    ;;
  $lock)
    loginctl lock-session
    ;;
  $suspend)
    ans=$(confirm_exit &)
    if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
      systemctl suspend
    elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
      exit 0
    fi
    ;;
  $logout)
    ans=$(confirm_exit &)
    if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
      loginctl terminate-session
    elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
      exit 0
    fi
    ;;
esac
