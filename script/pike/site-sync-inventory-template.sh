#!/bin/bash

SITES="site1.com
site2.com
sitexxx.com..."

echo "Inventory sync as of `date "+%Y-%m-%d %H:%M"`"

for SITE in $SITES
do
    echo "Processing site $SITE"

    SITE_DIR=/srv/www/$SITE/public_html/app/public

    if [[ ! -d $SITE_DIR ]]; then
        echo "Directory not found: $SITE_DIR"
        continue
    fi

    cd $SITE_DIR

    echo "Synchronizing $SITE"

    php index.php dropship inventory --sync --by=200 --max-iteration=40
done

exit 0
