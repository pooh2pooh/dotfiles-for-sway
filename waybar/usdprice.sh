#!/bin/bash

CACHE_FILE="/tmp/usdprice_last.cache"
CACHE_TTL=300 # 5 минут

# Функция для получения кэшированной цены из файла
get_cached_price() {
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

# Функция для получения курса USD/RUB с API и записи его в кэш
fetch_and_cache_price() {
    usd2rub=$(curl -s 'https://www.cbr-xml-daily.ru/daily_json.js' | jq -r '.Valute.USD.Value' | cut -c1-5)
    if [ -n "$usd2rub" ] && [ "$usd2rub" != "null" ]; then
        echo "$usd2rub" > "$CACHE_FILE"
        echo "$usd2rub"
    else
        echo ""
    fi
}

# Проверяем наличие интернета (ping)
if ping -c1 -W1 ping.archlinux.org >/dev/null 2>&1; then
    # Если интернет есть, получаем свежие данные и обновляем кэш
    usd2rub=$(fetch_and_cache_price)
    age=0
else
    # Если интернета нет, берём цену из кэша
    usd2rub=$(get_cached_price)
    age=$(get_cache_age)
fi

# Если нет никакой цены — выводим ошибку
if [ -z "$usd2rub" ]; then
    echo 'Ошибка!'
    exit 1
fi

# Если цена устарела (старше CACHE_TTL), выделяем её красным
if [ "$age" -ge "$CACHE_TTL" ]; then
    usd2rub="<span color='red'>$usd2rub</span>"
fi

# Выводим результат для waybar
# Можно добавить tooltip или json, если нужно

echo "$usd2rub"

