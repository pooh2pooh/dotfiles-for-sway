#!/bin/sh

re='^[0-9]+$'

if ping -c1 ya.ru &> /dev/null
  then updates=$(yay -Qqu | wc -l)
  else updates=0
fi

if [ $updates -gt 0 ] && [[ $updates =~ $re ]]; then
    echo " $updates"
else
    echo ""
fi
