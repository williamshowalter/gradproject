#!/bin/sh

# save wifi configuration
#
# Write configuration file for wpa_supplicant
#

Usage()
{
	echo "$0 ESSID _AuthMode _EncrypType [Password]"
}

if [ $# -le 2 ];then
	Usage
	exit 1
fi

ssid=$1
_AuthMode=$2
_EncrypType=$3

if [ $# -eq 4 ];then
	password=$4
fi

if [ $_AuthMode = "NONE" ];then
	AuthMode="OPEN"
	EncrypType="NONE"
elif [ $_AuthMode = "WEP" ];then
	AuthMode="WEPAUTO"
	EncrypType="WEP"
else
	AuthMode=$_AuthMode
	EncryType=$_EncrypType
fi

# EncrypType is not NONE, but without Passowrd set. Then failure.
if [ "$EncrypType" != "NONE" ] && [ -z $password ];then
	echo "@@WARNING: Miss Password, EncrypType is set to NONE"
	#exit;
	EncrypType="NONE"
fi

#All connect command should be seted.

CFGFILE=/mnt/mtd/cfg/wpa_supplicant.conf

if [ $AuthMode = "OPEN" ];then
cat > $CFGFILE <<ABCD
ctrl_interface=/var/run/wpa_supplicant
ctrl_interface_group=0
#eapol_version=1
update_config=1
ap_scan=1
network={
	ssid="$ssid"
	key_mgmt=NONE
	auth_alg=OPEN
	priority=r
}
ABCD
elif [ $AuthMode = "WEPAUTO" ];then

cat > $CFGFILE <<ABCD
ctrl_interface=/var/run/wpa_supplicant
ctrl_interface_group=0
#eapol_version=1
update_config=1
ap_scan=1
network={
	ssid="$ssid"
	key_mgmt=NONE
	priority=5
ABCD

KLEN=`echo ${#password}`
if [ $KLEN -eq 10 -o $KLEN -eq 26 -o $KLEN -eq 32 ]; then
cat >> $CFGFILE <<ABCD
	wep_key0=$password
}
ABCD
else
cat >> $CFGFILE <<ABCD
	wep_key0="$password"
}
ABCD
fi

else
cat > $CFGFILE <<ABCD
ctrl_interface=/var/run/wpa_supplicant
ctrl_interface_group=0
#eapol_version=1
update_config=1
ap_scan=1
network={
	ssid="$ssid"
	psk="$password"
	proto=WPA RSN
	key_mgmt=WPA-PSK
	pairwise=CCMP TKIP
	group=CCMP TKIP WEP104 WEP40
	priority=5
}
ABCD
fi

