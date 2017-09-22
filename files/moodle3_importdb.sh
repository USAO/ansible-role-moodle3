#!/usr/bin/env bash

PATH=/opt/usao/moodle3/bin:/usr/local/bin:/usr/bin:/bin:/sbin:$PATH

source /opt/usao/moodle3/etc/moodle3_conf.sh

if [  -z "$1" ]; then
  cat <<USAGE
moodle3_importdb.sh performs a database import to an moodle3 site.

Usage: moodle3_importdb.sh \$SITEPATH
            
\$SITEPATH  moodle3 target site for sql import (eg. /srv/example).
USAGE

  exit 1;
fi

SITEPATH=$1

echo "Importing $SITEPATH database"

## Grab the basename of the site to use in a few places.
SITE=$(basename "$SITEPATH")

## Import sql-dump
sudo -u apache bash -c "mysql -h $moodle3DBHOST -u $moodle3USER -p$moodle3PASS -D $moodle3DB < $SITEPATH/db/moodle3_${SITE}_dump.sql"

echo "Finished importing $SITEPATH database."

