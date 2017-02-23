#!/bin/sh
#
# $Id: wlan.sh, v1.00 2012-11-05 andy
#
# usage: wlan.sh 
#

echo "**** wlan.sh ***"

wlan_init.sh

lan_link=`gpio lanlink`
if [ "$lan_link" = "1" ]; then
exit 0
fi

sleep 2
gpio ping
sleep 2

# mydlink
#/mydlink/opt.local stop
#/mydlink/opt.local start
date
echo "*** wlan.sh -> mydlink ***"
gpio mydlink


