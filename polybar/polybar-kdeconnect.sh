#!/usr/bin/env bash

# CONFIGURATION
LOCATION=0
YOFFSET=0
XOFFSET=0
WIDTH=12
WIDTH_WIDE=24
rofi_path=$HOME/Projects/linux_setup/rofi
THEME=$rofi_path/runner/runner.rasi

# Color Settings of Icon shown in Polybar
COLOR_DISCONNECTED='#eeeeee'       # Device Disconnected
COLOR_NEWDEVICE='#eeeeee'          # New Device
COLOR_BATTERY_90='#eeeeee'         # Battery >= 90
COLOR_BATTERY_80='#eeeeee'         # Battery >= 80
COLOR_BATTERY_70='#eeeeee'         # Battery >= 70
COLOR_BATTERY_60='#eeeeee'         # Battery >= 60
COLOR_BATTERY_50='#eeeeee'         # Battery >= 50
COLOR_BATTERY_LOW='#eeeeee'        # Battery <  50

# COLOR_DISCONNECTED='#000'       # Device Disconnected
# COLOR_NEWDEVICE='#ff0'          # New Device
# COLOR_BATTERY_90='#fff'         # Battery >= 90
# COLOR_BATTERY_80='#ccc'         # Battery >= 80
# COLOR_BATTERY_70='#aaa'         # Battery >= 70
# COLOR_BATTERY_60='#888'         # Battery >= 60
# COLOR_BATTERY_50='#666'         # Battery >= 50
# COLOR_BATTERY_LOW='#f00'        # Battery <  50

# Icons shown in Polybar
ICON_SMARTPHONE=''
ICON_TABLET=''
SEPERATOR=''

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

show_devices (){
    IFS=$','
    devices=""
    for device in $(qdbus --literal org.kde.kdeconnect /modules/kdeconnect org.kde.kdeconnect.daemon.devices); do
        deviceid=$(echo "$device" | awk -F'["|"]' '{print $2}')
        devicename=$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$deviceid" org.kde.kdeconnect.device.name)
        devicetype=$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$deviceid" org.kde.kdeconnect.device.type)
        isreach="$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$deviceid" org.kde.kdeconnect.device.isReachable)"
        istrust="$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$deviceid" org.kde.kdeconnect.device.isTrusted)"
        if [ "$isreach" = "true" ] && [ "$istrust" = "true" ]
        then
            battery="$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$deviceid/battery" org.kde.kdeconnect.device.battery.charge)"
            icon=$(get_icon "$battery" "$devicetype")
            devices+="%{A1:$DIR/polybar-kdeconnect.sh -n '$devicename' -i $deviceid -b $battery -m:}$icon%{A}$SEPERATOR"
        elif [ "$isreach" = "false" ] && [ "$istrust" = "true" ]
        then
            # devices+="$(get_icon -1 "$devicetype")$SEPERATOR"
            devices+=" "
        else
            haspairing="$(qdbus org.kde.kdeconnect "/modules/kdeconnect/devices/$deviceid" org.kde.kdeconnect.device.hasPairingRequests)"
            if [ "$haspairing" = "true" ]
            then
                show_pmenu2 "$devicename" "$deviceid"
            fi
            icon=$(get_icon -2 "$devicetype")
            devices+="%{A1:$DIR/polybar-kdeconnect.sh -n $devicename -i $deviceid -p:}$icon%{A}$SEPERATOR"

        fi
    done
    echo "${devices::-1}"
}

show_menu () {
kdeconnect-app
}

show_pmenu () {
kdeconnect-settings
}

show_pmenu2 () {
kdeconnect-settings
}

get_icon () {
    if [ "$2" = "tablet" ]
    then
        icon=$ICON_TABLET
    else
        icon=$ICON_SMARTPHONE
    fi
    case $1 in
    "-1")     ICON="%{F$COLOR_DISCONNECTED}$icon%{F-}" ;;
    "-2")     ICON="%{F$COLOR_NEWDEVICE}$icon%{F-}" ;;
    5*)     ICON="%{F$COLOR_BATTERY_50}$icon%{F-}" ;;
    6*)     ICON="%{F$COLOR_BATTERY_60}$icon%{F-}" ;;
    7*)     ICON="%{F$COLOR_BATTERY_70}$icon%{F-}" ;;
    8*)     ICON="%{F$COLOR_BATTERY_80}$icon%{F-}" ;;
    9*|100) ICON="%{F$COLOR_BATTERY_90}$icon%{F-}" ;;
    *)      ICON="%{F$COLOR_BATTERY_LOW}$icon%{F-}" ;;
    esac
    echo $ICON
}

unset DEV_ID DEV_NAME DEV_BATTERY
while getopts 'di:n:b:mp' c
do
    # shellcheck disable=SC2220
    case $c in
        d) show_devices ;;
        i) DEV_ID=$OPTARG ;;
        n) DEV_NAME=$OPTARG ;;
        b) DEV_BATTERY=$OPTARG ;;
        m) show_menu  ;;
        p) show_pmenu ;;
    esac
done
