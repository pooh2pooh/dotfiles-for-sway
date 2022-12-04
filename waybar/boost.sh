#!/bin/bash

current_governor=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)

if [[ $current_governor == "powersave" || $current_governor == "schedutil" ]]; then
	echo "";
elif [[ $current_governor == "performance" ]]; then
	echo "";
else
	echo "";
fi
