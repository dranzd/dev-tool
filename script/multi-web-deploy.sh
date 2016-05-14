#!/bin/bash
# Site update version 0.001

BASE_DIR=/PATH/TO/BASE/DIR
GIT_DIR=/PATH/TO/GIT/REPO/release-version-git
RESULT_LOG=/PATH/TO/RESULT.LOG
E_XCD=87
BASE_SITE=REMOTE.HOSTNAME
USER=REMOTE.USER
PORT=REMOTE.PORT
SITES="SITE1.COM
SITE2.COM
..."

cd $BASE_DIR || {
    echo "Cannot change to necessary directory." >&2
    exit $E_XCD;
}

for SITE in $SITES
do
    echo "Deploying to site $SITE"
    rsync -rtoDCzvK --exclude-from=updater_exclude \
    -e "ssh -l $USER -p $PORT" \
    $GIT_DIR/ \
    "${BASE_SITE}:/srv/www/${SITE}/public_html/" \
    > $RESULT_LOG
done

exit 0
