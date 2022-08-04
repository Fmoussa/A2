#!/bin/bash

dlc=`wc -l /var/webserver_monitor/monitorlog.log | awk '{print $1}'`
ualc=`wc -l /var/webserver_monitor/unauthorized.log | awk '{print $2}'`

echo $dlc
echo $ualc

if [ "$dlc" != "$ualc" ]
then
     
        diff /var/webserver_monitor/unauthorized.log /var/webserver_monitor/monitorlog.log > new_invalid_access
        sudo sed -i "1d" new_invalid_access 
        sudo sed -i s/\<//g  new_invalid_access 
        mail -s "unauthorized.log updates" -A new_invalid_access bm117623@gmail.com < new_invalid_access 
        cp /var/webserver_monitor/unauthorized.log /var/webserver_monitor/monitorlog.log
else
        echo "No unauthaccess" | mail -s "No unauthorized access." bm117623@gmail.com
fi
