#!/bin/bash

SITES="site1.com
site2.com
sitexxx.com..."

RESTORE_WD=`pwd`

for SITE in $SITES
do
    echo -e "Warming up and purging assets of site \e[4m${SITE}\e[0m"

    SITE_DIR=/srv/www/$SITE/public_html/app/public

    if [[ ! -d $SITE_DIR ]]; then
        echo "Directory not found: $SITE_DIR"
        continue
    fi

    cd $SITE_DIR

    /usr/bin/php index.php assetmanager warmup --purge
done

cd $RESTORE_WD

exit 0
