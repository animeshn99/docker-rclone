#!/bin/sh

set -e

if [ ! -z "$TZ" ]
then
  cp /usr/share/zoneinfo/$TZ /etc/localtime
  echo $TZ > /etc/timezone
fi

rm -f /tmp/sync.pid

if [ -z "$SYNC_SRC" ] || [ -z "$SYNC_DEST" ]
then
  echo "INFO: No SYNC_SRC and SYNC_DEST found. Starting rclone config"
  rclone config $RCLONE_OPTS
  echo "INFO: Define SYNC_SRC and SYNC_DEST to start sync process."
else
  # SYNC_SRC and SYNC_DEST setup
  # run sync either once or in cron depending on CRON
  /sync.sh
fi

