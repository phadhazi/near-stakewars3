#!/bin/bash

DATE=$(date +%Y-%m-%d-%H-%M)

DATADIR=~/.near/data
BACKUPDIR=~/.near-backup/near_${DATE}

mkdir $BACKUPDIR

sudo systemctl stop neard.service

wait

echo "NEAR node was stopped" | ts

if [ -d "$BACKUPDIR" ]; then
    echo "Backup started" | ts

    cp -rf $DATADIR/ ${BACKUPDIR}/


    # Submit backup completion status, you can use healthchecks.io, betteruptime.com or other services
    curl -fsS -m 10 --retry 5 -o /dev/null https://hc-ping.com/bd3c7ded-c601-47f6-8cf6-e26ef3711ea3

    echo "Backup completed" | ts
else
    echo $BACKUPDIR is not created. Check your permissions.
    exit 0
fi

sudo systemctl start neard.service

echo "NEAR node was started" | ts


find ~/.near-backup/ | grep -v "near_$(date +%Y-%m-%d)" | grep -v '.near-backup/$' | xargs rm -rv
echo "Old backups have been cleaned" | ts