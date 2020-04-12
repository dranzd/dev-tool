#!/bin/bash

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
E_XCD=87
SITES=$(cat <<EOF
SITE1.COM
SITE2.COM
EOF
)

cd $BASE_DIR || {
    echo "Cannot change to necessary directory." >&2
    exit $E_XCD;
}

for SITE in $SITES
do
    echo "Backup $SITE"
    ./${SITE}.sh "$@"
done

exit 0
