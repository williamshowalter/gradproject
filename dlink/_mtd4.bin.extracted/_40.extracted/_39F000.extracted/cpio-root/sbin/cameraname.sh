#!/bin/sh
#
# $Id: cameraname.sh, v1.00 2009-11-05 andy
#
# usage: cameraname.sh
#

echo "*** begin cameraname.sh ***"

gpio semaphore wait 2

# re-set OSD time
gpio osd

# restart dhcp for camera name change (mydlink request -> will cause disconnection on mydlink relay mode)
# gpio dhcp

# restart mDNSResponder for camera change - Remove (use BonjourName)
# killall -q mDNSResponder
# gpio mDNSResponder

sleep 3
gpio semaphore clear 2