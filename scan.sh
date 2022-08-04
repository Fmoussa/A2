#!/bin/bash

set -x

echo -n '' | sudo tee -a /var/log/temporary.log

diflog=$(sudo diff /var/log/auth.log/var/log/temporary.log)

if[["$diflog" != "" ]]

then
  sudo comm -1 -3 /var/log/temporary.log /var/log/auth.log | sudo grep -i -E "invalid|fail" | while read -r line
  do
   date=$(echo "$line" | grep -i -o -E "^[a-z]*.\s[0-9]*\s")
    ip_address=$(echo "$line" | grep -o -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}")
    country=$(curl -s https://ipapi.co/$ip_address/country_name/)
  
    if [[ -n "$ip_address" ]]
    then
      echo "$ip_address $country $date" | sudo tee -a /share/log/ual.log 
    fi
  done 
  
  sudo cat /var/log/auth.log | sudo tee /var/log/temporary.log
fi
