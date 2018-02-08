#!/bin/bash

config="/etc/dhcp/dhcpd.conf"
leases="/var/lib/dhcp/dhcpd.leases"

declare -a ipcount
declare -a binmask
subnets=( $(cat $config | grep subnet | sed '/ *#/d; /^ *$/d' | awk '{ print $2 }') )
netmask=( $(cat $config | grep subnet | sed '/ *#/d; /^ *$/d' | awk '{ print $4 }') )
ipaddrs=( $(cat $leases | awk '{ if ($1 == "lease") { x=$2 } else { if (($1 == "binding") && ($3 == "active;")) { print x } } }' | sort | uniq ) )

for ((i=0;i<${#subnets[@]};i++));
        do
                ipcount[$i]=0
                binmask[$i]=`/usr/local/sbin/netbin.pl ${netmask[$i]}`
        done

for ((i=0;i<${#ipaddrs[@]};i++));
        do
                for ((j=0;j<${#subnets[@]};j++));
                        do
                                srchost=`/usr/local/sbin/iptonet.pl ${ipaddrs[$i]} ${subnets[$j]} ${netmask[$j]}`
                                let ipcount[$j]="${ipcount[$j]} + $srchost"
                        done
        done
touch /var/log/zabbix/dhcp.zbx
for ((i=0;i<${#subnets[@]};i++));
        do
                maxhosts=`/usr/local/sbin/netmax.pl ${netmask[$i]}`
                echo ${subnets[$i]}"/"${binmask[$i]}" "$maxhosts" "${ipcount[$i]} >> /var/log/zabbix/dhcp.zbx
        done
chown zabbix /var/log/zabbix/dhcp.zbx
mv -f /var/log/zabbix/dhcp.zbx /var/log/zabbix/dhcp.cnt
