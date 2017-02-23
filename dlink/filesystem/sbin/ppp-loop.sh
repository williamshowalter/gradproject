#!/bin/sh

PPP_CFG_OK=/tmp/config-ppp-ok
while [ 1 ]; do
	if [ -f "$PPP_CFG_OK" ]; then
		sleep 3
		rm -f $PPP_CFG_OK
		echo "pppd start.............."
		/bin/pppd call 3g
	fi
	sleep 5
done