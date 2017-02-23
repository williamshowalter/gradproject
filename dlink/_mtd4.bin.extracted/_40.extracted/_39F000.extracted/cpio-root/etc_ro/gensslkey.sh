#!/bin/sh
# re-generate SSL Server Keys
cd /etc_ro
mkdir /usr/local
mkdir /usr/local/ssl
cp openssl.cnf /usr/local/ssl
openssl genrsa -out serverkey.pem 1024
openssl req -new -key serverkey.pem -x509 -out servercert.pem -days 1825 -subj  "/C=TW/ST=Taiwan/L=Taipie/O=D-LINK/OU=DHPD Dept./CN=www.dlink.com"
cd /
