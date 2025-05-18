#!/bin/bash

CACHE_FILE="/tmp/arch_updates.cache"
CACHE_TTL=600 # 10 минут

# Функция для получения кэшированного значения
get_cached_updates() {
    if [ -f "$CACHE_FILE" ]; then
        cat "$CACHE_FILE"
    fi
}

# Функция для получения возраста кэша в секундах
get_cache_age() {
    if [ -f "$CACHE_FILE" ]; then
        echo $(( $(date +%s) - $(stat -c %Y "$CACHE_FILE") ))
    else
        echo 999999
    fi
}

# Функция для проверки наличия интернета
check_internet() {
    ping -c1 -W1 ping.archlinux.org &> /dev/null
}

# Функция для получения количества обновлений и записи в кэш
fetch_and_cache_updates() {
    updates=$(yay -Qqu | wc -l)
    if [[ "$updates" =~ ^[0-9]+$ ]]; then
        echo "$updates" > "$CACHE_FILE"
        echo "$updates"
    else
        echo ""
    fi
}

# Основная логика
if check_internet; then
    age=$(get_cache_age)
    if [ "$age" -ge "$CACHE_TTL" ]; then
        updates=$(fetch_and_cache_updates)
    else
        updates=$(get_cached_updates)
    fi
else
    updates=$(get_cached_updates)
    age=$(get_cache_age)
fi

# Если нет данных — ничего не выводим
if [ -z "$updates" ]; then
    echo ""
    exit 0
fi

# Если есть обновления и кэш устарел — выделяем красным
if [ "$updates" -gt 0 ]; then
    if [ "$age" -ge "$CACHE_TTL" ]; then
        echo "<span color='red'>  $updates</span>"
    else
        echo "  $updates"
    fi
else
    echo ""
fi

