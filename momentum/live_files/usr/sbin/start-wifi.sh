#!/bin/sh

# start wifi
# for supplicant controled interface

Usage()
{
	echo "$0 Interface [ESSID _AuthMode _EncrypType Password]"
}

if [ $# -lt 1 ];then
	Usage
	exit 1
fi

INTF=$1
CFGFILE=/mnt/mtd/cfg/wpa_supplicant.conf

killall wpa_supplicant > /dev/null 2>&1
svc_starter wpa_supplicant -i $INTF -c $CFGFILE -D wext -B

