#!/bin/bash

vpn1=$(ip link | grep wg0-client)
vpn2=$(ip link | grep wg1)

if [[ ${vpn1} > 0 ]];
then
				echo "󰞀 "
fi

if [[ ${vpn2} > 0 ]];
then
				echo "󰒘 "
fi
