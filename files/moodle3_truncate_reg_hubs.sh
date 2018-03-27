#!/usr/bin/env bash

PATH=/opt/usao/moodle3/bin:/usr/local/bin:/usr/bin:/bin:/sbin:$PATH

if [  -z "$1" ]; then
  cat <<USAGE
moodle3_truncate_reg_hubs.sh removes moodle.net registration info from a moodle3 database. Intended for dev and test sites copied from production databases.

Usage: moodle3_truncate_reg_hubs.sh \$SITEPATH

\$SITEPATH  moodle3 target site for registration hub table truncation (eg. /srv/example).
USAGE

  exit 1;
fi

source /opt/usao/moodle3/etc/moodle3_conf.sh

SITEPATH=$1

## Grab the basename of the site to use in a few places.
SITE=$(basename "$SITEPATH")

## truncate mdl_registration_hubs
sudo -u apache bash -c "echo 'truncate mdl_registration_hubs;' | mysql -h $moodle3DBHOST -u $moodle3USER -p$moodle3PASS -D $moodle3DB"

echo "Truncated mdl_registration_hubs table in $SITEPATH database."
