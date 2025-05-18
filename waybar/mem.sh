#!/bin/bash

mem=$(free | awk 'NR==2 { printf "%.0f\n", $3 * 100 / $2 }')
interval=25
progress=$(echo "scale=0; ($mem + $interval - 1) / $interval" | bc) 
fstring=""

for ((i = 0; i < progress; i++)); do
	if [[ $i -eq 2 ]]
		then fstring="<span color='#cb4b16'> </span>"
	elif [[ $i -eq 3 ]]
		then fstring="<span color='#dc322f'> </span>"
	else fstring="<span color='#859900'> </span>"
	fi
done

echo $fstring

