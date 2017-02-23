#!/bin/sh
#
# $Id: wlan_for_sitesurvey.sh, v1.00 2012-11-05 andy
#
# usage: wlan_for_sitesurvey.sh 
#

echo "**** wlan_for_sitesurvey.sh ***"

wlan_init.sh

lan_link=`gpio lanlink`
if [ "$lan_link" = "1" ]; then
exit 0
fi

sleep 2
gpio ping

