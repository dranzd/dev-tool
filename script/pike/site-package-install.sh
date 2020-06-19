#!/bin/bash

# Do a composer install on all sites' framework based app directory

SITES="site1.com
site2.com
site3.com"

echo "NPM install `date "+%Y-%m-%d %H:%M"`"

RESTORE_WD=`pwd`

for SITE in $SITES
do
    echo "Processing site $SITE"

    SITE_DIR=/var/www/html/$SITE/public_html/js

    if [[ ! -d $SITE_DIR ]]; then
        echo "Directory not found: $SITE_DIR"
        continue
    fi

    cd $SITE_DIR

    echo "Installing NPM for $SITE"

    npm install --production
done

cd $RESTORE_WD

exit 0
