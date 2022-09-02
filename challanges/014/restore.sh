#!/bin/bash

DATADIR=~/.near/data
BACKUPDIR=$(ls -td ~/.near-backup/* | head -1)
TMPDIR=~/tmp

echo $DATADIR
echo $BACKUPDIR
echo $TMPDIR

if [ -d "$BACKUPDIR" ]; then
  echo AAAA
  sudo systemctl stop neard.service
  wait
  echo "NEAR node was stopped" | ts

  rm -rf $TMPDIR/data

  echo "Backup restore started" | ts

  mv -v  $DATADIR $TMPDIR/
  cp -rv  $BACKUPDIR/data/ $DATADIR

  echo "Backup restore completed" | ts

else
  echo There is no backup available | ts
  exit 0
fi

  sudo systemctl start neard.service
  echo "NEAR node was started" | ts
