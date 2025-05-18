#!/bin/bash

# Проверяем, запущен ли сервис bluetooth
if ! systemctl is-active --quiet bluetooth; then
    # Сервис bluetooth не запущен
    echo "󰂯"
    exit 0
fi

# Проверяем, включён ли Bluetooth-адаптер
bluetooth_powered=$(bluetoothctl show 2>/dev/null | grep -q "Powered: yes" && echo 1 || echo 0)

if [[ $bluetooth_powered -eq 1 ]]; then
    # Bluetooth включён
    echo "<span color='#859900'>󰂯</span>"
else
    # Bluetooth выключен
    echo "󰂯"
fi

