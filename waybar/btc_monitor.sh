#!/bin/bash

CACHE_FILE="/tmp/btc_monitor_lastprice.cache"
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

# Функция для получения цены с API и записи её в кэш
fetch_and_cache_price() {
    response=$(curl -s "https://open-api.bingx.com/openApi/swap/v2/quote/ticker?symbol=BTC-USDT")
    lastPrice=$(echo "$response" | jq -r '.data.lastPrice')
    if [ -n "$lastPrice" ] && [ "$lastPrice" != "null" ]; then
        echo "$lastPrice" > "$CACHE_FILE"
        echo "$response"
    else
        echo ""
    fi
}

# Проверяем наличие интернета (ping)
if ping -c1 -W1 ping.archlinux.org >/dev/null 2>&1; then
    # Если интернет есть, получаем свежие данные и обновляем кэш
    response=$(fetch_and_cache_price)
else
    # Если интернета нет, response будет пустым
    response=""
fi

# Если нет свежих данных (нет интернета или ошибка API)
if [ -z "$response" ]; then
    # Берём цену из кэша и определяем её возраст
    lastPrice=$(get_cached_price)
    age=$(get_cache_age)
    priceChange="?"
    lowPrice="?"
    highPrice="?"
else
    # Если есть свежие данные, парсим их
    lastPrice=$(echo "$response" | jq -r '.data.lastPrice')
    priceChange=$(echo "$response" | jq -r '.data.priceChange')
    lowPrice=$(echo "$response" | jq -r '.data.lowPrice')
    highPrice=$(echo "$response" | jq -r '.data.highPrice')
    age=0
fi

# Если нет никакой цены — выводим ошибку
if [ -z "$lastPrice" ]; then
    echo '{"text":"Ошибка!","tooltip":"Нет данных"}'
    exit 1
fi

# Если цена устарела (старше CACHE_TTL), выделяем её красным
if [ "$age" -ge "$CACHE_TTL" ]; then
    lastPrice="<span color='red'>$lastPrice</span>"
fi

# Формируем tooltip для waybar
tooltip="$priceChange\n\n<span foreground='red'></span>  $lowPrice\n<span foreground='green'></span>  $highPrice"
# Формируем JSON для waybar
json_output=$(printf '{"text":"  %s","tooltip":"%s"}' "$lastPrice" "$tooltip")

echo "$json_output"

