#!/bin/bash

BASE_DIR=/path/to/basedir
GIT_DIR=/path/to/basedir/git/release
EXCLUDE_FROM_FILE=/path/to/basedir/tools/updater_exclude.txt
LOG=/path/to/rsync.log
E_XCD=87
BASE_SITE=basesite.com
USER=USER
PORT=XXXX

cd $BASE_DIR || {
    echo -e "Cannot change to necessary directory." >&2
    exit $E_XCD;
}

DRY_RUN='-n '
TARGET='TARGET'
SHOW_CMD_ONLY=false

while [[ $# -gt 0 ]]
do
    key="$1"

    case $key in
        --push)
            DRY_RUN=""
        ;;

        -n|--dry-run)
            DRY_RUN="-n "
        ;;

        -c|--show-command-only)
            SHOW_CMD_ONLY=true
        ;;

        -t|--target)
            if [[ ! -z $2 ]]; then
                TARGET=$2
            fi
            shift
        ;;

        *)
            # unknown option
            shift
        ;;
    esac

    shift
done

SITE="${TARGET}.basesite.com"

if [ "$TARGET" == "TARGET1" ]; then
    SITE="xxx.xxx.xxx.xx1"
elif [ "$TRAGET" == "TARGET2" ]; then
    SITE="xxx.xxx.xxx.xx2"
fi

echo -e "Deploying to site \e[4m${SITE}\e[0m"

CMD="rsync ${DRY_RUN}-rtoDCzvK --exclude-from=${EXCLUDE_FROM_FILE} -e \"ssh -l $USER -p $PORT\" ${GIT_DIR}/ ${SITE}:/srv/www/${BASE_SITE}/public_html/"

if [[ $SHOW_CMD_ONLY == true ]]; then
    echo -e "\e[32m${CMD} > ${LOG}\e[0m"
else
    echo -e "** Executing command"
    echo -e "\e[32m${CMD} > ${LOG}\e[0m"
    eval "$CMD > $LOG"
fi

exit 0
