#!/bin/bash
DATE=$(date +%F)
curl -o /tmp/$DATE https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts
echo "" > /etc/unbound/unbound.conf.d/blockservers.conf
for line in $(more /tmp/$DATE | grep -v "#" |grep -v "localhost" | grep -v "127.0.0.1 local" | grep -v "broadcasthost" | sort | uniq | awk '{print $2}')
do
echo "local-zone: " "$line" redirect" " >> /etc/unbound/unbound.conf.d/blockservers.conf
echo "local-data: " "$line A 127.0.0.1" "" >> /etc/unbound/unbound.conf.d/blockservers.conf
done

