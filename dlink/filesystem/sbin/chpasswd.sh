#!/bin/sh
#
# $Id: chpasswd.sh, v1.00 2009-11-05 andy
#
# usage: chpasswd.sh <user name> [<password>]
#

if [ "$1" == "" ]; then
    echo "chpasswd: no user name"
    exit 1
fi

echo "$1:$2" > /tmp/tmpchpw
chpasswd < /tmp/tmpchpw
rm -f /tmp/tmpchpw
