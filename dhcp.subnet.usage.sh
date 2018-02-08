#!/bin/bash
m=`cat /var/log/zabbix/dhcp.cnt | grep $1 | /usr/bin/awk '{ print $2 }'`
#l=`cat /var/log/zabbix/dhcp.cnt | grep $1 | /usr/bin/awk '{ print $3 }'`
l="11"
k=$(($l * 100))
p=$(($k / $m))
q=$(($k % $m))
echo $m,$l,$k,$p,$q
