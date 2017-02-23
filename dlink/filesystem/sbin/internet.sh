#!/bin/sh
#
# $Id: internet.sh, v1.00 2009-11-05 andy
#
# usage: internet.sh
#

sleep 1

echo "*****************"
echo "*  INTERNET.SH  *"
echo "*****************"

# run config.sh if this shell script have any configuration symbol
#. /sbin/config.sh

lan_if="br0"

# setup username:password
login=`nvram_get 2860 AdminID`
if [ "$login" = "" ]; then
echo "loading default configuration ..."
sleep 3
login=`nvram_get 2860 AdminID`
fi
pass=`nvram_get 2860 AdminPassword`
echo "$login::0:0:Adminstrator:/:/bin/sh" > /etc/passwd
echo "$login:x:0:$login" > /etc/group
chpasswd.sh $login $pass

# disable lan
gpio lan 0

# ftp server for wireless throughput test
echo "21 stream tcp nowait $login /usr/bin/ftpd ftpd -w" > /etc/inetd.conf
gpio telnetd_ftpd
#inetd &

# Set RT3352 to dump switch mode (restore to no VLAN partition)
switch reg w 14 5555
switch reg w 40 1001
switch reg w 44 1001
switch reg w 48 1001
switch reg w 4c 1
switch reg w 50 2001
switch reg w 70 ffffffff
switch reg w 98 7f7f
switch reg w e4 7f

sleep 1

# setup wlan interface
echo "ifconfig ra0 0.0.0.0 ......"
ifconfig ra0 0.0.0.0

# setup lo interface -- mydlink need it
echo "ifconfig lo up ......"
ifconfig lo up

# setup bridge, lan and wlan interface, and fast forwarding time (setfd, setmaxage)
echo "ifconfig eth2 0.0.0.0 ......"
ifconfig eth2 0.0.0.0

# setup bridge interface, and fast forwarding time (setfd, setmaxage)
brctl addbr br0
brctl addif br0 ra0
brctl addif br0 eth2

brctl setfd br0 1
brctl setmaxage br0 1 

# setup wlan 
wlan_init.sh

# enable lan
gpio lan 1

# setup lan
lan.sh

# audio
pcmcmd -s -q 11025 &

# video 
videomon &
uvc_stream -b -m 0 -g 5 -e 5 &
sleep 1
h264 &
sleep 1

# pan/tilt control for DCS-5020L and DCS-5010L
wt6703f &
swing

# lltd
lld2d $lan_if

# ir/icr
gpio ir

# ping (send arp)
gpio ping &

echo "************************"
echo "*  END OF INTERNET.SH  *"
echo "************************"


