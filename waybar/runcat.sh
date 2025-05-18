#!/bin/bash
# filepath: /home/pooh/dotfiles/waybar/runcat.sh

CAT_PATH="/home/pooh/Downloads/tmp"
RUN_FRAMES=(0 1 2 3 4)
SLEEP_FRAME=5

# Получаем загрузку CPU (среднее за 0.5 секунды)
prev_idle=$(awk '/^cpu /{print $5}' /proc/stat)
prev_total=$(awk '/^cpu /{s=0; for(i=2;i<=NF;i++) s+=$i; print s}' /proc/stat)
sleep 0.5
idle=$(awk '/^cpu /{print $5}' /proc/stat)
total=$(awk '/^cpu /{s=0; for(i=2;i<=NF;i++) s+=$i; print s}' /proc/stat)
diff_idle=$((idle - prev_idle))
diff_total=$((total - prev_total))
if [ "$diff_total" -eq 0 ]; then
    cpu_load=0
else
    cpu_load=$((100 * (diff_total - diff_idle) / diff_total))
fi

if [ "$cpu_load" -lt 5 ]; then
    echo "$CAT_PATH/$SLEEP_FRAME.svg"
    exit 0
fi

# Чем выше загрузка, тем быстрее анимация (от 1 до 10 кадров в секунду)
speed=$(awk -v cpuval="$cpu_load" 'BEGIN{ s=int(1+(cpuval/100)*9); if(s<1)s=1; if(s>10)s=10; print s }')
frame_count=${#RUN_FRAMES[@]}
frame=$(( ($(date +%s%N) / 1000000000 * speed) % frame_count ))
echo "$CAT_PATH/${RUN_FRAMES[$frame]}.svg"