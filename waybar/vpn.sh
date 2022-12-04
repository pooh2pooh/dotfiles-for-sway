#!/bin/bash

vpn=$(ip link | grep wg0-client)

if [[ ${vpn} > 0 ]];
then
				echo "廬"
fi
