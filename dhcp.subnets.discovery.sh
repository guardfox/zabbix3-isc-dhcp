#mv -f /var/log/zabbix/dhcp.zbx /var/log/zabbix/dhcp.cnt
#done by crond ( parse just counter file)
#!/bin/bash
echo '{"data":[' ;
cat /var/log/zabbix/dhcp.cnt | /usr/bin/awk '{print "{\"{#SUBNET}\":\"" $1 "\"},"}' | /bin/sed '$s,\,,,g'
echo ']}'
