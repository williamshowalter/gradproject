#!/bin/sh
echo [$0] $1 $2 ... > /dev/console

if [ "$1" == "" || "$2" == "" ]; then
	echo Invalid parameters > /dev/console
	exit 0
fi
###########################################################################
if [ "$1" == "add" ]; then
	sh /sbin/config-3g-ppp.sh -m $2 -c 3g_connect.scr -d 3g_disconnect.scr
fi
###########################################################################
if [ "$1" == "remove" ]; then
	killall -q pppd
	rmmod usbserial
fi
###########################################################################
echo [$0] Exit ... > /dev/console
