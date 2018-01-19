#!/usr/bin/env bash

PATH=/opt/usao/moodle3/bin:/usr/local/bin:/usr/bin:/bin:/sbin:$PATH

if [  -z "$1" ]; then
    cat <<USAGE
moodle3_snapshot.sh creates a db dump and tar backup for a site.

Usage: moodle3_snapshot.sh \$SITEPATH
            
\$SITEPATH moodle3 site to tar (eg. /srv/example).

Backups will be stored at $SITEPATH/snapshots/$SITE.$DOW.tar.gz. $DOW is
the lowercase day-of-week abbreviation for the current day.

USAGE
    exit 1;
fi

source /opt/usao/moodle3/etc/moodle3_conf.sh

SITEPATH=$1
SITE=$(basename "$SITEPATH")
moodle3BASENAME=$(basename "${moodle3DIR}")
SNAPSHOTDIR="$SITEPATH/snapshots"
DOW=$( date +%a | awk '{print tolower($0)}')

if [[ ! -e "$SITEPATH" ]]; then
    echo "Can't create snapshot of nonexistent site at $SITEPATH."
    exit 1;
fi

echo "Making ${DOW} snapshot for $SITEPATH"

# Make a db backup in case the latest one is old
moodle3_dump.sh $SITEPATH

# Tar files required to rebuild, with $SITE as TLD inside tarball. 
sudo -u apache tar -czf  "$SNAPSHOTDIR/$SITE.$DOW.tar.gz" -C ${moodle3PARENT}/ "${SITE}/db" "${SITE}/etc" "${SITE}/moodledata" "${SITE}/${moodle3BASENAME}"

echo "Snapshot created at ${SNAPSHOTDIR}/${SITE}.${DOW}.tar.gz"
