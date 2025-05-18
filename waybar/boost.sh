#!/bin/bash

current_governor=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 2>/dev/null)
current_scaling=$(lscpu | grep 'CPU(s) scaling MHz' | awk '{ print $4; }')
icon=""

get_governor_icon () {
    case "$current_governor" in
        performance)
            icon="" # Performance
            ;;
        powersave)
            icon="" # Powersave
            ;;
        ondemand)
            icon="" # Ondemand
            ;;
        conservative)
            icon="" # Conservative
            ;;
        schedutil)
            icon="" # Schedutil
            ;;
        userspace)
            icon="" # Userspace
            ;;
        *)
            icon="" # Неизвестный governor
            ;;
    esac
}

get_governor_icon

if [[ -z $icon ]]
then
	sleep 5
	get_governor_icon
fi

echo "{\"text\":\"$icon\", \"tooltip\":\"Масштабирование ЦП: $current_scaling ($current_governor)\"}"
exit 0

