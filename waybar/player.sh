#!/bin/bash

player_cmus=$(playerctl --player=cmus status 2> /dev/null)
player_mpv=$(playerctl --player=mpv status 2> /dev/null)
player_spotify=$(playerctl --player=spotify status 2> /dev/null)
player_firefox=$(playerctl --player=firefox status 2> /dev/null)
player_telegram=$(playerctl --player=TelegramDesktop status 2> /dev/null)
player=$(playerctl status 2> /dev/null)

if [[ $player_cmus = "Playing" ]]; then
	echo "  $(playerctl --player=cmus metadata title)" | cut -c 1-92
elif [[ $player_cmus = "Paused" ]]; then
	echo "  $(playerctl --player=cmus metadata title)" | cut -c 1-92
elif [[ $player_spotify = "Playing" ]]; then
	echo " $(playerctl --player=spotify metadata --format "{{artist}} - {{album}} - {{title}}")" | cut -c 1-92
elif [[ $player_spotify = "Paused" ]]; then
	echo "  $(playerctl --player=spotify  metadata --format "{{artist}} - {{album}} - {{title}}")" | cut -c 1-92 -n
elif [[ $player_mpv = "Playing" ]]; then
	echo "  $(playerctl --player=mpv metadata title)" | cut -c 1-92
elif [[ $player_mpv = "Paused" ]]; then
	echo "  $(playerctl --player=mpv metadata title)" | cut -c 1-92
elif [[ $player_firefox = "Playing" ]]; then
  echo "󰈹 $(playerctl --player=firefox metadata --format "{{artist}} - {{album}} - {{title}}")" | cut -c 1-92
elif [[ $player_firefox = "Paused" ]]; then
  echo " $(playerctl --player=firefox metadata --format "{{artist}} - {{album}} - {{title}}")" | cut -c 1-92
elif [[ $player_telegram = "Playing" ]]; then
  echo " $(playerctl --player=TelegramDesktop metadata --format "{{artist}} - {{album}} - {{title}}")" | cut -c 1-92
elif [[ $player_telegram = "Paused" ]]; then
  echo " $(playerctl --player=TelegramDesktop metadata --format "{{artist}} - {{album}} - {{title}}")" | cut -c 1-92
elif [[ $player = "Playing" ]]; then
	echo "  $(playerctl metadata title)" | cut -c 1-92
elif [[ $player = "Paused" ]]; then
	echo " PAUSED"
else
    echo ""
fi
