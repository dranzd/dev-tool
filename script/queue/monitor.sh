#/bin/bash

COUNT=`ps -fC php | grep -c "index.php queue doctrine default --start"`

echo -e "Found process: $COUNT"

if [[ $COUNT == 0 ]]; then
    echo -e "Process not running, executing now..."
    /path/to/script/queue/run.sh
else
    echo -e "Process already running."
    echo -e "Exiting..."
fi
