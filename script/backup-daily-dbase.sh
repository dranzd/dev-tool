#!/bin/bash

FILENAME="backup-`date --date="1 day ago" +'%Y%m%d-020001'`.sql.gz"
DEST="/destination/directory"
COMMAND="scp -P 1122 user@domain.com:~/source/$FILENAME $DEST/$FILENAME"

if [ ! -f $DEST/$FILENAME ]; then
    echo "Executing command: "
    echo $COMMAND
    $COMMAND
else
    echo "File $FILENAME already has a backup!"
fi

exit 0
