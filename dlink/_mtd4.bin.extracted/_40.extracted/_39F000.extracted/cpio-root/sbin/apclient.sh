#!/bin/sh

###############################################################
ap_client_stop () {
	iwpriv apcli0 set ApCliEnable=0
	brctl delif br0 apcli0
	ifconfig apcli0 down
	echo "ap-client stop............"
}

ap_client_start () {
	ifconfig apcli0 up
	brctl addif br0 apcli0

#	auth_mode="WPAPSK"	#$(nvram_get ApCliAuthMode)
#	encryp_type="TKIP"	#$(nvram_get ApCliEncrypType)
#	ssid="WZR-AG300NH_AndyC"	#$(nvram_get ApCliSsid)
#	wpapsk_key="12345678"	#$(nvram_get ApCliWPAPSK)
#	iwpriv apcli0 set ApCliEnable=0
#	iwpriv apcli0 set ApCliAuthMode=$auth_mode
#	iwpriv apcli0 set ApCliEncrypType=$encryp_type
#	iwpriv apcli0 set ApCliSsid=$ssid
#	iwpriv apcli0 set ApCliWPAPSK=$wpapsk_key
#	iwpriv apcli0 set ApCliDefaultKeyID=1
#	iwpriv apcli0 set ApCliEnable=1

	echo "ap-client start...."
}
###############################################################

ap_stop () {
	brctl delif br0 ra1
	ifconfig ra1 down
	rmmod rt2860v2_ap
	echo "AP stop....."
}

ap_start () {
	ifconfig ra0 down
	insmod rt2860v2_ap.ko
	ifconfig ra1 up
	brctl addif br0 ra1

#	ap_ssid="RT3352APx"	#$(nvram_get AP_SSID)
#	ap_auth="WPAPSK"	#$(nvram_get AP_AuthMode)
#	ap_encryp="TKIP"	#$(nvram_get AP_EncrypMode)
#	ap_wpapsk="12345678"	#$(nvram_get AP_WPAPSK)
#	iwpriv ra1 set AuthMode=$ap_auth
#	iwpriv ra1 set EncrypType=$ap_encryp
#	iwpriv ra1 set IEEE8021X=0
#	iwpriv ra1 set SSID=$ap_ssid
#	iwpriv ra1 set WPAPSK=$ap_wpapsk
#	iwpriv ra1 set DefaultKeyID=2
#	iwpriv ra1 set SSID=$ap_ssid
        
	echo "AP start........"
}
###############################################################

case $1 in
"")
	echo "usage: apclient <start|stop|restart>"
	;;
"start")
	ap_start
	ap_client_start
        gpio repeater_link 0
        gpio repeater_mode 1
        gpio repeater
	;;
"stop")
	ap_client_stop
	ap_stop
        gpio repeater_link 0
        gpio repeater_mode 0
	;;
"restart")
	ap_client_stop
	ap_stop
	sleep 1
	ap_start
	ap_client_start
        gpio repeater_link 0
        gpio repeater_mode 1
        gpio repeater
	;;
esac

