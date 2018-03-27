#!/usr/bin/env bash


PATH=/opt/usao/moodle3/bin:/usr/local/bin:/usr/bin:/bin:/sbin:$PATH

## Require arguments
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] ; then
    cat <<USAGE
moodle3_migrate.sh migrates a site between hosts.
Usage: moodle3_migrate.sh \$dest_moodledir \$src_moodlehost \$src_cfgdir
\$dest_moodledir          local dir for Moodle site (eg. /srv/example).
\$src_moodlehost           host of site to migrate
\$src_cfgdir   remote dir of site to migrate on \$src_moodlehost
USAGE
    exit 1;
fi

source /opt/usao/moodle3/etc/moodle3_conf.sh

dest_moodledir=${1}
src_moodlehost=${2}
src_cfgdir=${3}
dest_basename=$(basename "$dest_moodledir")

# Read src config file
src_cfg=$(ssh ${src_moodlehost} cat ${src_cfgdir}/config.php)

# Set vars from it.
src_dbhost=`echo "${src_cfg}" | grep '^$CFG->dbhost' | cut -d "=" -f 2 | cut -d ';' -f 1 | xargs`
src_dbname=`echo "${src_cfg}" | grep '^$CFG->dbname' | cut -d "=" -f 2 | cut -d ';' -f 1 | xargs`
src_dbuser=`echo "${src_cfg}" | grep '^$CFG->dbuser' | cut -d "=" -f 2 | cut -d ';' -f 1 | xargs`
src_dbpass=`echo "${src_cfg}" | grep '^$CFG->dbpass' | cut -d "=" -f 2 | cut -d ';' -f 1 | xargs`
src_wwwroot=`echo "${src_cfg}" | grep '^$CFG->wwwroot' | cut -d "=" -f 2 | cut -d ';' -f 1 | xargs`
src_dataroot=`echo "${src_cfg}" | grep '^$CFG->dataroot' | cut -d "=" -f 2 | cut -d ';' -f 1 | xargs`


# Sync over the moodledata
rsync -avz ${src_moodlehost}:${src_dataroot}/ ${dest_moodledir}/moodledata/

# Dump src db to local file in dest_moodledir
ssh ${src_moodlehost} mysqldump --single-transaction --lock-tables=false --allow-keywords --opt -h${src_dbhost} -u${src_dbuser} -p${src_dbpass} ${src_dbname} >${dest_moodledir}/db/moodle3_${src_moodlehost}_dump.sql

# change sitename in db dump.
sed -e "s#${src_wwwroot}#${moodle3wwwroot}#g" ${dest_moodledir}/db/moodle3_${src_moodlehost}_dump.sql > ${dest_moodledir}/db/moodle3_${dest_basename}_dump.sql

# Import our newly munged database
/opt/usao/moodle3/bin/moodle3_importdb.sh ${dest_moodledir}

# Upgrade our db to the installed codebase
/opt/usao/moodle3/bin/moodle3_upgrade.sh ${dest_moodledir}
