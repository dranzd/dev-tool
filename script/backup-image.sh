#!/bin/bash

EXCLUDE_FROM_FILE=/path/to/git/source/_docs/dev/image_copy_rsync_exclude
LOG_FILE=/path/to/rsync.log
USER=user
PORT=1234
REMOTE=remote.com

SRC_URL=domain.com
SRC_DIR="/srv/www/${SRC_URL}/public_html/images/"

DST_DIR="/path/to/backup/${SRC_URL}/latest/images/"

DRY_RUN='-n '
SHOW_CMD_ONLY=false

while [[ $# -gt 0 ]]
do
    key="$1"

    case $key in
        --run)
            DRY_RUN=""
        ;;

        -c|--show-command-only)
            SHOW_CMD_ONLY=true
        ;;

        *)
            # unknown option
            shift
        ;;
    esac

    shift
done

echo -e "Running image backup of site \e[4m${SITE}\e[0m"

CMD="rsync ${DRY_RUN} --copy-links -rtgoDCzvK --exclude-from=${EXCLUDE_FROM_FILE} -e \"ssh -l ${USER} -p ${PORT}\" ${REMOTE}:${SRC_DIR} ${DST_DIR}"

if [[ $SHOW_CMD_ONLY == true ]]; then
    echo -e "\e[32m${CMD} >> ${LOG_FILE}\e[0m"
else
    echo -e "** Executing command"
    echo -e "\e[32m${CMD} >> ${LOG_FILE}\e[0m"
    eval "$CMD >> $LOG_FILE"
fi

exit 0
