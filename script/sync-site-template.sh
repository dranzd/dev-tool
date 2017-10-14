#!/bin/bash

SRC_DIR=/path/to/source/directory/
DEST_PATH=public_html/uploads/vendor/image/
LOG=/path/to/file.log
E_XCD=87
HOST=host.com
USER=user
PORT=22
SITES="site1.com
site2.com
sitexxx.com..."

DRY_RUN='-n '
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

        -s|--site)
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

if [[ ! -z $TARGET ]]; then
    SITES=$TARGET
fi

echo '' > $LOG

for SITE in $SITES
do
    echo -e "Synchronizing to site \e[4m${SITE}\e[0m :: DESCRIPTION HERE"

    CMD="rsync ${DRY_RUN}-crtgoDCzvK -e \"ssh -l $USER -p $PORT\" ${SRC_DIR} ${HOST}:/srv/www/${SITE}/{DEST_PATH}"

    if [[ $SHOW_CMD_ONLY == true ]]; then
        echo -e "\e[32m${CMD} >> ${LOG}\e[0m"
    else
        echo -e "** Executing command"
        echo -e "\e[32m${CMD} >> ${LOG}\e[0m"
        echo "---------------------------------------------------" >> $LOG
        echo "synchronizing $SITE" >> $LOG
        echo "---------------------------------------------------" >> $LOG
        eval "$CMD >> $LOG"
    fi
done

exit 0
