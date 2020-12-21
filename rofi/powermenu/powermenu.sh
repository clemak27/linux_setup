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
    if [[ -f /usr/bin/i3lock ]]; then
      i3lock
    elif [[ -f /usr/bin/betterlockscreen ]]; then
      betterlockscreen -l
    else
      loginctl lock-session
    fi
    ;;
  $suspend)
    ans=$(confirm_exit &)
    if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
      mpc -q pause
      amixer set Master mute
      systemctl suspend
    elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
      exit 0
    fi
    ;;
  $logout)
    ans=$(confirm_exit &)
    if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
      if [[ "$DESKTOP_SESSION" == "Openbox" ]]; then
        openbox --exit
      elif [[ "$DESKTOP_SESSION" == "bspwm" ]]; then
        bspc quit
      elif [[ "$DESKTOP_SESSION" == "i3" ]]; then
        i3-msg exit
      fi
    elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
      exit 0
    fi
    ;;
esac
