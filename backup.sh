#!/usr/bin/env bash

set -e
[ "${DEBUG:-false}" == 'true' ] && set -x

echo "==> Running Backup"

# Defaults 

: ${BACKUP_KEEP:=30}  # Keep 30 days
: ${BACKUP_DEST:='/mnt/s3'}
: ${BACKUP_SRC:=''}
: ${BACKUP_TMP:='/tmp'}
: ${BACKUP_NAME:=$(date +%Y%m%d%H%M%S)}

# Tests
[ $BACKUP_SRC == "" ] && echo "BACKUP_SRC not specified" && exit 128

# Perform backup
tar -czf ${BACKUP_TMP}/${BACKUP_NAME}.tgz $BACKUP_SRC
mv ${BACKUP_TMP}/${BACKUP_NAME}.tgz $BACKUP_DEST

# cleanup
find $BACKUP_DEST -type f -mtime +${BACKUP_KEEP} -exec rm -f {} \;

echo "Done"
