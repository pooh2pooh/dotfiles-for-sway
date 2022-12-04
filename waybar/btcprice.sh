#!/bin/sh

# CONFIG HERE VAR!
FILE=/tmp/btc_current_price

if [[ -f $FILE ]];
  then btc2rub=$(cat $FILE)
  else btc2rub="_" # if not defiened!
fi

DATA=$(curl -s 'https://blockchain.info/ticker' | jq -r '.RUB .buy')

if ping -c1 ya.ru &> /dev/null;
  then
    echo $DATA | cut -f1 -d. | numfmt --to=si > $FILE
    btc2rub=$(cat $FILE)
    
fi
if [[ ${#btc2rub} -ge 5 ]]
  then echo "Ошибка!"
  else echo $btc2rub 
fi
#printf "%'.2f\n" $DATA
