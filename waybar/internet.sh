#!/bin/bash

# Проверка подключения к интернету
ping -c1 ping.archlinux.org > /dev/null 2>&1

# Проверка статуса команды ping
if [ $? -ne 0 ]; then
    # Если подключение отсутствует, выводится красная иконка глобуса
    echo "<span color='#aa0000'>󰕑 </span>"
fi

