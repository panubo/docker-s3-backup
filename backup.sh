#!/usr/bin/env bash

set -e
[ "${DEBUG:-false}" == 'true' ] && set -x

echo "==> Running Backup"

# Defaults 

: ${BACKUP_KEEP:=30}  # Keep 30 days
: ${BACKUP_DST:='/mnt/s3'}
: ${BACKUP_SRC:=''}
: ${BACKUP_TMP:='/tmp'}
: ${BACKUP_NAME:=$(date +%Y%m%d%H%M%S)}
: ${BACKUP_EXCLUDE:=''}
: ${BACKUP_PASSPHRASE:=''}

# Tests
[ "$BACKUP_SRC" == "" ] && echo "Error: BACKUP_SRC not specified" && exit 128

# Arg building
[ "$BACKUP_EXCLUDE" != "" ] && for I in $BACKUP_EXCLUDE; do EXCLUDE_ARGS+="--exclude ${I} "; done

# Perform backup
if [ "$BACKUP_PASSPHRASE" == "" ]; then
    tar -czf ${BACKUP_TMP}/${BACKUP_NAME}.tgz $EXCLUDE_ARGS $BACKUP_SRC
    mv ${BACKUP_TMP}/${BACKUP_NAME}.tgz $BACKUP_DST
else
    tar -cz $EXCLUDE_ARGS $BACKUP_SRC | openssl enc -e -aes-256-cbc -salt -k $BACKUP_PASSPHRASE -out ${BACKUP_TMP}/${BACKUP_NAME}.tgz.enc
    mv ${BACKUP_TMP}/${BACKUP_NAME}.tgz.enc $BACKUP_DST
fi

# cleanup
find $BACKUP_DST -type f -mtime +${BACKUP_KEEP} -exec rm -f {} \;

echo "Done"
