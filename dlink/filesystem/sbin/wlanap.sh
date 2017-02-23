#!/bin/sh
#
# $Id: wlanap.sh, v1.00 2009-11-11 andy
#
# usage: wlanap.sh 
#

echo "**** wlanap.sh ***"

insmod -q rt2860v2_ap

ifconfig ra1 0.0.0.0
brctl addif br0 ra1
