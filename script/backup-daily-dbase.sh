#!/bin/bash

LOG_FILE=/path/to/rsync.log
USER=user
PORT=1234
REMOTE=remote.com

FILENAME="backup-`date --date="1 day ago" +'%Y%m%d-020001'`.sql.gz"
DBASE=domain
SRC_DIR="~/source/${DBASE}/"
DST_DIR="/path/to/backup/${DBASE}/dbase/"

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

SITE=${DBASE}
echo -e "Running dbase backup of site \e[4m${SITE}\e[0m"

CMD="scp -P ${PORT} ${USER}@${REMOTE}:${SRC_DIR}${DBASE}-${FILENAME} ${DST_DIR}${FILENAME}"

if [[ $SHOW_CMD_ONLY == true ]]; then
    echo -e "\e[32m${CMD} >> ${LOG_FILE}\e[0m"
else
    echo -e "** Executing command"
    echo -e "\e[32m${CMD} >> ${LOG_FILE}\e[0m"
    if [[ -z "${DRY_RUN}" ]]; then
        eval "$CMD >> $LOG_FILE"
    fi
fi

exit 0
