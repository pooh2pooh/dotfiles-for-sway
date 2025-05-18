#!/usr/bin/env python3

import json
import requests
from datetime import datetime
import time

WEATHER_CODES = {
    '113': '☀️',
    '116': '⛅️',
    '119': '☁️',
    '122': '☁️',
    '143': '🌫',
    '176': '🌦',
    '179': '🌧',
    '182': '🌧',
    '185': '🌧',
    '200': '⛈',
    '227': '🌨',
    '230': '❄️',
    '248': '🌫',
    '260': '🌫',
    '263': '🌦',
    '266': '🌦',
    '281': '🌧',
    '284': '🌧',
    '293': '🌦',
    '296': '🌦',
    '299': '🌧',
    '302': '🌧',
    '305': '🌧',
    '308': '🌧',
    '311': '🌧',
    '314': '🌧',
    '317': '🌧',
    '320': '🌨',
    '323': '🌨',
    '326': '🌨',
    '329': '❄️',
    '332': '❄️',
    '335': '❄️',
    '338': '❄️',
    '350': '🌧',
    '353': '🌦',
    '356': '🌧',
    '359': '🌧',
    '362': '🌧',
    '365': '🌧',
    '368': '🌨',
    '371': '❄️',
    '374': '🌧',
    '377': '🌧',
    '386': '⛈',
    '389': '🌩',
    '392': '⛈',
    '395': '❄️'
}

data = {}


def get_weather():
    for _ in range(3):  # Повторяем попытку 3 раза в случае неудачи
        try:
            weather = requests.get("https://wttr.in/Belgorod?format=j1", timeout=5).json()
            return weather
        except requests.RequestException as e:
            print(f"Failed to fetch weather data. Error: {e}")
            time.sleep(5)  # Ждем 5 секунд перед повторной попыткой
    return None


def format_time(time):
    return time.replace("00", "").zfill(2)


def format_temp(temp):
    return (hour['FeelsLikeC']+"°").ljust(3)


def format_chances(hour):
    chances = {
        "chanceoffog": "Fog",
        "chanceoffrost": "Frost",
        "chanceofovercast": "Overcast",
        "chanceofrain": "Rain",
        "chanceofsnow": "Snow",
        "chanceofsunshine": "Sunshine",
        "chanceofthunder": "Thunder",
        "chanceofwindy": "Wind"
    }

    conditions = []
    for event in chances.keys():
        if int(hour[event]) > 0:
            conditions.append(chances[event]+" "+hour[event]+"%")
    return ", ".join(conditions)


# Получаем погоду с возможными повторными попытками
weather = get_weather()

if weather:
    data['text'] = WEATHER_CODES[weather['current_condition'][0]['weatherCode']] + \
        " " + weather['current_condition'][0]['FeelsLikeC']+ "°" + \
        " " + weather['current_condition'][0]['weatherDesc'][0]['value']

    data['tooltip'] = f"<b>{weather['current_condition'][0]['weatherDesc'][0]['value']} {weather['current_condition'][0]['temp_C']}°</b>\n"
    data['tooltip'] += f"Feels like: {weather['current_condition'][0]['FeelsLikeC']}°\n"
    data['tooltip'] += f"Wind: {weather['current_condition'][0]['windspeedKmph']}Km/h\n"
    data['tooltip'] += f"Humidity: {weather['current_condition'][0]['humidity']}%\n"
    for i, day in enumerate(weather['weather']):
        data['tooltip'] += f"\n<b>"
        if i == 0:
            data['tooltip'] += "Today, "
        if i == 1:
            data['tooltip'] += "Tomorrow, "
        data['tooltip'] += f"{day['date']}</b>\n"
        data['tooltip'] += f"⬆️ {day['maxtempC']}° ⬇️ {day['mintempC']}° "
        data['tooltip'] += f" {day['astronomy'][0]['sunrise']}  {day['astronomy'][0]['sunset']}\n"
        for hour in day['hourly']:
            if i == 0:
                if int(format_time(hour['time'])) < datetime.now().hour-2:
                    continue
            data['tooltip'] += f"{format_time(hour['time'])} {WEATHER_CODES[hour['weatherCode']]} {format_temp(hour['FeelsLikeC'])} {hour['weatherDesc'][0]['value']}, {format_chances(hour)}\n"
else:
    # В случае неудачи выводим иконку загрузки
    data['text'] = '⌛'
    data['tooltip'] = "Получаю погоду..."


print(json.dumps(data))
