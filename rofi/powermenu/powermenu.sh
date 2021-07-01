#!/usr/bin/env bash

rofi_path=$HOME/Projects/linux_setup/rofi

rofi_command="rofi -theme $rofi_path/powermenu/powermenu.rasi"

uptime=$(uptime -p | sed -e 's/up //g')

# Options
shutdown="     Power off"
  reboot="     Reboot"
    lock="     Lock Screen"
 suspend="⏾     Sleep"
  logout="     Logout"

# Confirmation
confirm_exit() {
  $rofi_path/confirm/confirm.sh $1
}

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 2)"
case $chosen in
  $shutdown)
    ans=$(confirm_exit "Power off" &)
    if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
      systemctl poweroff
    elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
      exit 0
    fi
    ;;
  $reboot)
    ans=$(confirm_exit "Reboot" &)
    if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
      systemctl reboot
    elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
      exit 0
    fi
    ;;
  $lock)
    sleep 1 && ~/Projects/linux_setup/scripts/lock.sh
    ;;
  $suspend)
    ans=$(confirm_exit "Sleep" &)
    if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
      systemctl suspend
    elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
      exit 0
    fi
    ;;
  $logout)
    ans=$(confirm_exit "Logout" &)
    if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
      loginctl | egrep -v "root|SESSION|listed" | awk '{print $1}' | xargs loginctl terminate-session
    elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
      exit 0
    fi
    ;;
esac
