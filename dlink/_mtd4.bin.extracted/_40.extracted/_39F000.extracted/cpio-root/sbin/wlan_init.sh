#!/bin/sh
#
# $Id: wlan_init.sh, v1.00 2012-11-05 andy
#
# usage: wlan_init.sh 
#

echo "**** wlan_init.sh ***"

apclient.sh stop
ifconfig ra0 down
gpio wlan 1

lan_link=`gpio lanlink`
if [ "$lan_link" = "1" ]; then
echo "***** lan link, so don't up wlan *****"
exit 0
fi

wlan_disable=`nvram_get 2860 WirelessDisable`
wlan_mode=`nvram_get 2860 WirelessMode`
connection_mode=`nvram_get 2860 ConnectionMode`

if [ "$wlan_disable" = "0" ]; then
if [ "$wlan_mode" = "0" ]; then
echo "***** client mode *****"
gpio wlan 0
ifconfig ra0 up
fi

if [ "$wlan_mode" = "1" ]; then
if [ "$connection_mode" = "0" ]; then
echo "***** repeater mode *****"
apclient.sh start
fi
if [ "$connection_mode" = "1" ]; then
echo "***** client mode *****"
gpio wlan 0
ifconfig ra0 up
fi
fi
fi

if [ "$wlan_disable" = "1" ]; then
echo "***** wireless disable *****"
gpio wlan 1
fi

