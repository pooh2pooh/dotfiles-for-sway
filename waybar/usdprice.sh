#!/bin/sh

# CONFIG HERE VAR!
FILE=/tmp/usd_current_price

if [[ -f $FILE ]];
  then usd2rub=$(cat $FILE)
  else usd2rub="_" # if not defiened!
fi

DATA=$(curl -s 'https://www.cbr-xml-daily.ru/daily_json.js' | jq -r '.Valute.USD.Value')

if ping -c1 ya.ru &> /dev/null;
  then
    echo $DATA | cut -c1-5 > $FILE
    usd2rub=$(cat $FILE)
fi

if [[ ${#usd2rub} -ge 6 ]]
  then echo "Ошибка!"
  else echo $usd2rub
fi

#printf "%s\n" $DATA
