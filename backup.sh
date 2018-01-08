#!/bin/sh
set -xe

duplicity \
  $DUPLICITY_FLAGS \
  --archive-dir="/cache" \
  --allow-source-mismatch \
  --no-encryption \
  --asynchronous-upload \
  --full-if-older-than=${FULL_IF_OLDER_THAN} \
  $BACKUP_SRC \
  $BACKUP_DEST

duplicity \
  remove-older-than ${REMOVE_OLDER_THAN} \
  $DUPLICITY_FLAGS \
  --archive-dir="/cache" \
  --no-encryption \
  --force \
  $BACKUP_DEST

duplicity \
  cleanup \
  $DUPLICITY_FLAGS \
  --archive-dir="/cache" \
  --no-encryption \
  --force \
  $BACKUP_DEST
