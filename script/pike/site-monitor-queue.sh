#/bin/bash

COUNT=`ps -fC php | grep -c "index.php queue doctrine default --start"`

echo -e "Found process: $COUNT"

if [ $COUNT -eq 0 ]; then
  echo -e "Process not running, executing now..."
  ./site-run-queue.sh
else
  echo -e "Process already running."
  echo -e "Exiting..."
fi
