#!/bin/bash

# Установить имя и путь к директории сохранения видео
SAVE_DIR="$HOME/Videos"

# Установить источник аудио (например, микрофон)
AUDIO_SOURCE="default" # Измените на конкретное устройство, если необходимо

# Проверить активное состояние записи видео
if [ -z "$(pgrep wf-recorder)" ]; then
  # Запустить запись видео со звуком
  FILENAME=$(date +%Y-%m-%d_%H-%M-%S).mp4
  wf-recorder -g "$(slurp)" -f $SAVE_DIR/$FILENAME -a $AUDIO_SOURCE &
  notify-send "Запись видео начата"
else
  # Остановить запись видео
  pkill -SIGINT wf-recorder
  notify-send "Запись видео завершена"
fi

