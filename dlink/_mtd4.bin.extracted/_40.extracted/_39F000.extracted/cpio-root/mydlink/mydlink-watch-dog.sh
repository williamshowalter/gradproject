#!/bin/sh

########################
# http server checking #
########################
MAX_COUNT=5
TDB_CMD=
HTTP_HC=

restart_httpd_930() {
  #echo "restart 930L/932L"
  killall -q alphapd
  alphapd& 
}

restart_httpd_1100s() {
  echo "restart 1100L/1130L/5230L/942L/5222L" > /dev/null
  /etc/rc.d/init.d/lighttpd.sh stop
  /etc/rc.d/init.d/lighttpd.sh start
}

check_httpd() {
  active=0
  count=0

  if [ -d "/mydlink" ]; then
    TDB_CMD="/mydlink/tdb"
    HTTP_HC="/mydlink/httpd_check"
    port=`$TDB_CMD get HTTPServer Port_num`
  else
    TDB_CMD="mdb"
    HTTP_HC="/opt/httpd_check"
    port=`mdb get http_port`
  fi

  # 0. get the target http port
  #port=`$TDB_CMD get HTTPServer Port_num`
  if [ "a$port" == "a" ]; then
    port=80
  fi

  # 1. retry at most 5 times
  while [ "$active" -eq "0" ] && [ "$count" -lt "$MAX_COUNT" ]
  do
    # 2. check health of the http server
    $HTTP_HC $port > /dev/null
    if [ "$?" -eq "0" ]; then
      active=1
    else
      echo "httpd check failed"
      count=`expr $count + 1`
      sleep 6
    fi
  done

  # 3. if found http server dead, restart the http server
  if [ "$count" -ge "$MAX_COUNT" ]; then
    # restart http server
    echo "http server doesn't repond properly, restart it"
    restart_httpd_930
    restart_httpd_1100s
  fi
}


##########################
# mydlink agent checking #
##########################
# $1: process name
# $2: launch argument
check_alive() {
  pid=`ps | grep $1 | grep -v grep | sed 's/^[ \t]*//'  | sed 's/ .*//'`
  if [ -z "$pid" ]; then
    echo "[`date`] $1 is not running!"

    killall $1
    $MYDLINK_BASE/$1 $2 > /dev/null 2>&1 &
  fi
}

# Check duplicate agents
check_duplicate_agents() {
  num=`ps | grep $MYDLINK_BASE/signalc | grep -v grep -c`
  if [ "$num" -gt "1" ]; then
    echo "[`date`] Duplicate signalc ..."
    $MYDLINK_BASE/opt.local start
  fi
}

# Get mydlink folder
MYDLINK_BASE="/mydlink"
if [ -f /mydlink/signalc ]; then
  MYDLINK_BASE="/mydlink"
elif [ -f /opt/signalc ]; then
  MYDLINK_BASE="/opt"
fi

# Set mydlink into PATH
export PATH=$MYDLINK_BASE:$PATH

# Get model name
MODEL_NAME="Unknown"
HAS_MDB=`mdb get dev_model | grep "L" -c`
if [ "1" -eq "$HAS_MDB" ]; then
  MODEL_NAME=`mdb get dev_model`
else
  wlan=`pibinfo Wireless`
  if [ "$wlan" = "1" ]; then
    MODEL_NAME=`tdb get System ModelW_ss`
  else
    MODEL_NAME=`tdb get System Model_ss`
  fi
fi

# Get LAN interface
LAN_INT="br0"
HAS_BR0=`ifconfig | grep "br0" -c`
if [ "$HAS_BR0" -eq "1" ]; then
  LAN_INT="br0"
else
  LAN_INT="eth0"
fi

# Check agent status
while [ 1 ]
do
  sleep 5

  #check duplicate agents
  check_duplicate_agents
  
  # check mydlink agents
  check_alive signalc
  check_alive dcp "-i $LAN_INT -m $MODEL_NAME"

  # check http service
  check_httpd

done

