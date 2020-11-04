#!/bin/bash
CURRENT=$(df / | grep / | awk '{ print $5}' | sed 's/%//g')
THRESHOLD=90
EMAIL=mailid@domainname.com

if [ "$CURRENT" -gt "$THRESHOLD" ] ; then
    mail -s 'Low Disk Space Alert' $EMAIL << EOF
Your root partition remaining free space is critically low. Used: $CURRENT%
EOF
fi
