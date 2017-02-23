#!/bin/sh
#
# $Id: video.sh, v1.00 2009-11-11 andy
#
# usage: video.sh 
#

echo "**** video.sh ****"
file_pcmcmd=/var/run/pcmcmd.pid
file_uvc_stream=/var/run/uvc_stream.pid
file_h264=/var/run/h264.pid

gpio semaphore wait 1
gpio video 0

killall -q pcmcmd
killall -q uvc_stream
killall -q h264
time_start=$(date +%s)
while [ 1 ]
do
	time_current=$(date +%s)
	time_diff=$(( $time_current - $time_start ))
	if [ $time_diff -ge 10 ]; then
		echo "video.sh (kill process) timeout!!"
		break
	fi
	if [ -e $file_pcmcmd ]; then
#		echo "wait (pcmcmd) exit"
		continue
	fi
	if [ -e $file_uvc_stream ]; then
#		echo "wait (uvc_stream) exit"
		continue
	fi
	if [ -e $file_h264 ]; then
#		echo "wait (h264) exit"
		continue
	fi
	break
done
echo "video.sh (kill process).....$time_diff seconds."
rm -f file_pcmcmd
rm -f file_uvc_stream
rm -f file_h264
###########################
#Reload ov780 F/W
ov780 -r 120 -i 100
#sleep 4
###########################

pcmcmd -s -q 11025 &
uvc_stream -b -m 0 -g 5 -e 5 &
h264 &

time_start=$(date +%s)
while [ 1 ]
do
	time_current=$(date +%s)
	time_diff=$(( $time_current - $time_start ))
	if [ $time_diff -ge 20 ]; then
		echo "video.sh (execute process) timeout!!"
		break
	fi
#	echo "wait...(pcmcmd,uvc_stream,h264)...ready"
	if [ ! -e $file_pcmcmd ]; then
#		echo "wait (pcmcmd) ready"
		continue
	fi
	if [ ! -e $file_uvc_stream ]; then
#		echo "wait (uvc_stream) ready"
		continue
	fi
	if [ ! -e $file_h264 ]; then
#		echo "wait (h264) ready"
		continue
	fi
	break
done

echo "video.sh (execute process).....$time_diff seconds."
gpio osd
gpio ir
gpio video 1
gpio semaphore clear 1
