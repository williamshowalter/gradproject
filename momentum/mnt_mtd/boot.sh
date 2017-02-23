
#!/bin/sh
if [ ! -f /mnt/mtd/upgrade_id ]; then
	cd /mnt/mtd
	tar -zxf ko-other-ipc019.tgz -C /tmp
	cd /tmp/ko-other-ipc019
	./load.sh
	touch /mnt/mtd/upgrade_id
	/mnt/mtd/test_gpio --setflick 1 1 1
	sleep 999999
fi

if [ ! -f /etc/TZ ]; then
	ln -s /mnt/mtd/TZ /etc/TZ
fi
if [ ! -f /mnt/mtd/TZ ]; then
	echo 'GMT-08:00' > /mnt/mtd/TZ
fi

ifconfig lo up
ifconfig eth0 up
telnetd

rm -fr /tmp/*
cd /mnt/mtd

KOTGZ=`ls ko*.tgz`
for i in $KOTGZ
do
  echo load $i ...
  tar xzf $i -C /tmp
  cd /tmp
  KODIR=`ls /tmp`
  cd $KODIR
  LOADSCRIPT=`ls load*`
  source $LOADSCRIPT
  cd /mnt/mtd
  rm -fr /tmp/*
done

/mnt/mtd/lowpower.sh > /dev/null 2>&1

cd /mnt/mtd
mdev -s

if [ ! -d /mnt/rd ]; then mkdir /mnt/rd; fi
#mkdosfs /dev/ram0
#mount -t vfat /dev/ram0 /mnt/rd
mkdir -p /mnt/rd/jpeg

#tar xzf uploader.tgz -C /bin
tar xzf libssl.tgz -C /lib
if [ -f /mnt/mtd/rt-lib++.tgz ]; then tar xzf /mnt/mtd/rt-lib++.tgz -C /lib; fi
if [ -f /mnt/mtd/dana_upd.tgz ]; then
	tar xzf /mnt/mtd/dana_upd.tgz -C /mnt
	/mnt/dana_upd &
fi

tar xzf html.np.tgz -C /mnt
tar xzf CHS.FON.tgz -C /mnt
ipc_tgz=`ls ipc-hi3518*.tgz`
tar xzf $ipc_tgz -C /mnt
mv /mnt/svc_starter /mnt/ddnsclt /bin
svc_starter
mkdir /var/log
syslogd

/mnt/mtd/sy_hook

/mnt/mtd/pintest rst
if [ $? -eq 1 ]; then
	#ssid=`grep ssid /mnt/mtd/cfg/net.ini | awk '{print $3}'`
	#sed -i "s/$ssid//g" /mnt/mtd/cfg/net.ini
	exit
fi

cd /mnt
ipc_cmd=`ls ipc-hi3518*`
RETVAL=3

ulimit -s 2048
until [ $RETVAL -ne 3 ]
do
	set -o pipefail
	./$ipc_cmd | /mnt/mtd/logwtch -v
	RETVAL=$?
	set +o pipefail
	if [ $RETVAL -eq 3 ]; then
		killall wpa_supplicant > /dev/null 2>&1
		killall udhcpc > /dev/null 2>&1
	fi
done
date >> /mnt/mtd/log.txt

uploader $RETVAL /mnt/mtd/cfg/cfgusr.ini
reboot

