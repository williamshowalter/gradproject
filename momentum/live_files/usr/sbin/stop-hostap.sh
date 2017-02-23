#!/bin/sh

ifconfig ra0 down
killall udhcpd
rmmod mt7601Uap
tgz=`ls /mnt/mtd/ko-wifi-mt7601*.tgz`
rm -fr /tmp/*
tar xzf $tgz -C /tmp
KODIR=`ls /tmp/`
cd /tmp/$KODIR
./load.sh
cd ..
rm -fr /tmp/$KODIR
