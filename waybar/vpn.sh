#!/bin/bash

# Проверяем наличие VPN-интерфейсов (wg*, tun*, tap*)
vpn_iface=$(ip link | grep -E 'wg[0-9a-zA-Z_-]*|tun[0-9a-zA-Z_-]*|tap[0-9a-zA-Z_-]*')

# Проверяем наличие процессов популярных VPN-клиентов
vpn_proc=$(pgrep -f -a 'openvpn|wireguard|xray|v2ray|tailscale|nordvpn')

# Если найден хотя бы один VPN-интерфейс или процесс — выводим индикатор
if [[ -n "$vpn_iface" || -n "$vpn_proc" ]]; then
    echo "VPN"
fi

