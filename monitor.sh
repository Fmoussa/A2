#!/bin/bash

set -x 

echo '' | sudo tee -a webserver_log/temp.log

diflog=$(sudo diff /webserver_log/unauth.log /webserver_log/temp.log)

if [ "$diflog" != "" ]

then
  echo -n "Unauthorized access report: $diflog" | mail -s "New Unauthorized Access" bm944281@wcupa.edu
  sudo cat /webserver_log/unauth.log | sudo tee /webserver_log/temp.log
        
else
        echo "No unauthaccess" | mail -s "No unauthorized access." bm944281@wcupa.edu
fi
