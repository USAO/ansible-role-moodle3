#!/usr/bin/env bash

PATH=/opt/usao/moodle3/bin:/usr/local/bin:/usr/bin:/bin:/sbin:$PATH

source /opt/usao/moodle3/etc/moodle3_conf.sh

if [  -z "$1" ]; then
  cat <<USAGE
moodle3_dump.sh performs a dump of the database for a moodle3 site.

Usage: moodle3_dump.sh \$SITEPATH
            
\$SITEPATH  moodle3 site to sql dump (eg. /srv/example).
USAGE

  exit 1;
fi

SITEPATH=$1

echo "Dumping $SITEPATH database"

## Grab the basename of the site to use in a few places.
SITE=$(basename "$SITEPATH")

## Perform sql-dump
sudo -u apache bash -c "mysqldump -h $moodle3DBHOST -u $moodle3USER -p$moodle3PASS $moodle3DB > $SITEPATH/db/moodle3_${SITE}_dump.sql"

echo "Finished dumping $SITEPATH database."
