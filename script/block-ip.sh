#/bin/bash

echo -e "\e[36mIP Blocking Tool\e[0m"

IP="$1"
LOCATION="$2"

if [[ -z "$IP" ]]; then
        echo -e "\t * \e[1;31mIP is required\e[0m"
        exit 0
fi

if [[ -z "$LOCATION" ]]; then
    echo -e "\t * \e[1;31mLOCATION is required\e[0m"
    exit 0
fi

REMOTES="user@site1.com
otheruser@site2.com
moreuser@site3.com"

CMD="sudo iptables -I INPUT 2 -s $IP -j DROP -m comment --comment \"Blocking $LOCATION\""

for REMOTE in $REMOTES
do
        echo -e "\t * \e[1;32mBlocking IP $IP with location $LOCATION on REMOTE $REMOTE\e[0m"
        ssh -p 1122 -t $REMOTE "$CMD"
done
