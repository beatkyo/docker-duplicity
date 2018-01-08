#!/bin/sh
trap 'kill -TERM $PID' TERM INT

CRON_SCHEDULE=${CRON_SCHEDULE:?}

BACKUP_SRC=${BACKUP_SRC:?}
BACKUP_DEST=${BACKUP_DEST:?}
FULL_IF_OLDER_THAN=${FULL_IF_OLDER_THAN:?}
REMOVE_OLDER_THAN=${REMOVE_OLDER_THAN:?}

export BACKUP_SRC
export BACKUP_DEST
export FULL_IF_OLDER_THAN
export REMOVE_OLDER_THAN

env

echo "$CRON_SCHEDULE /backup.sh" > crontab.conf
crontab crontab.conf

crond -f &
PID=$!

          # Not a typo.
wait $PID # First wait is interrupted by signal.
wait $PID # Second wait waits for trap.
