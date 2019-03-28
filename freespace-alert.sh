#!/bin/bash
df -H | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{ print $5 " " $1 }' | while read -r output;
do
  echo "$output"
  usep=$(echo "$output" | awk '{ print $1}' | cut -d'%' -f1  )
  partition=$(echo "$output" | awk '{ print $2 }' )
  if [ "$usep" -ge 90 ]; then
    echo "Space is low on \"$partition ($usep%)\" on $(hostname) as on $(date)" |
    mail -s "Alert: Disk usage is above 90% ($usep%)" root@localhost # Change to the email address this alert should go to
  fi
done
