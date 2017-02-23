#!/bin/sh
#WIFI config for RaLink 2070/3070...


Usage()
{
echo "$0 Interface ESSID _AuthMode _EncrypType [Password]"
echo "ESSID     : The Access Point ESSID"
echo ""
echo "_AuthMode : NONE, WEP, WPAPSK, WPA, WPA2, WPA2PSK, WPAPSKWPA2PSK"
echo "             NONE        Open system"
echo "             WEP        Use WEP"
echo "                WPA            Use WPA-Supplicant"
echo "                WPA2              Use WPA-Supplicant"
echo "                WPAPSK          For WPA pre-shared key"
echo "         WPA2PSK         For WPA2 pre-shared key"
echo "         WPAPSKWPA2PSK    WPAPSK/WPA2PSK mix mode"

echo ""
echo "_EncrypType: OPEN, SHARE, TKIP, AES, TKIPAES"
echo "             OPEN          For _AuthMode=NONE or WEP"
echo "             SHARED        Shared key system. For _AuthMode=WEP"
echo "             TKIP        For _AuthMode=WPAPSK or WPA2PSK"
echo "             AES        For _AuthMode=WPAPSK or WPA2PSK"
echo "             TKIPAES        TKIP/AES Mixed"

echo "Password : Depend on and EncrypType " 
echo "         If EncrypType=NONE, no need such argument."
echo "         Else, password should be set as the KEY or WPAPSK password."
echo ""
}


if [ $# -le 3 ] ; then 
    Usage;
    exit;
fi

#####################################
#
#    Stop wifi & install SoftAP KO
#
#####################################
killall wpa_supplicant > /dev/null  2>&1
killall udhcpc > /dev/null  2>&1
killall udhcpd > /dev/null  2>&1
ifconfig $1 down
rmmod mt7601Usta > /dev/null  2>&1

rm -fr /tmp/*
tar xzf /mnt/mtd/wifi-mt7601-softap.tgz -C /tmp
cwd=`pwd`
cd /tmp
KODIR=`ls /tmp`
cd $KODIR
./load.sh
cd $cwd
rm -fr /tmp/$KODIR

ifconfig ra0 up

########################
#
#  Set to AP mode
#
########################
WIFI_INT=$1
ssid=$2
_AuthMode=$3
_EncrypType=$4

# If get 4 arguments, the 4th argument is the password
if [ $# -eq 5 ] ; then
password=$5
fi

if [ $_AuthMode = "NONE" ]; then
	AuthMode="OPEN"
	EncrypType="NONE"
elif [ $_AuthMode = "WEP" ]; then
	AuthMode="WEPAUTO"
	EncrypType="WEP"
else
	AuthMode=$_AuthMode
	EncrypType=$_EncrypType
fi

# EncrypType is not NONE, but without Password set. Then failure.
if [ $EncrypType != "NONE" ] && [ -z $password ]; then 
    echo "@@WARNING: Miss Password, EncrypType is set to NONE"
    #exit;
    EncrypType="NONE"
fi

#All connect command need set them, so I put it here.
#iwpriv $WIFI_INT set NetworkType=Infra
iwpriv $WIFI_INT set AuthMode=$AuthMode
iwpriv $WIFI_INT set EncrypType=$EncrypType


if [ $EncrypType = "NONE" ]; then 
    iwpriv $WIFI_INT set SSID=$ssid
elif [ $EncrypType = "WEP" ]; then
    iwpriv $WIFI_INT set DefaultKeyID=1
    iwpriv $WIFI_INT set Key1=$password
    iwpriv $WIFI_INT set SSID=$ssid
else
    iwpriv $WIFI_INT set WPAPSK=$password
    iwpriv $WIFI_INT set SSID="$ssid"
fi

#############
#
#  udhcpd
#
#############
cat > /etc/udhcpd.conf <<TEXT
start 192.168.200.100
end  192.168.200.120

interface $WIFI_INT

#opt	dns	192.168.10.2 192.168.10.10
option	subnet	255.255.255.0
opt	router	192.168.200.1
#option	dns	129.219.13.81	# appened to above DNS servers for a total of 3
#option	domain	local
option	lease	864000		# 10 days of seconds

lease_file  /etc/udhcpd.lease
#pidfile     /var/run/udhcpd.pid

TEXT

echo "" > /etc/udhcpd.lease
ifconfig $WIFI_INT 192.168.200.1
svc_starter udhcpd -S /etc/udhcpd.conf

echo "wifi ap $SSID started ..."

