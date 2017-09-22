## Read useful values out of the config file
moodle3PARENT=`dirname ${1}`
moodle3DIR=`readlink -f ${1}/moodle3`
moodle3CFG=${moodle3DIR}/config.php
moodle3DBHOST=`cat $moodle3CFG | grep '^$CFG->dbhost' | cut -d "=" -f 2 | cut -d ';' -f 1 | xargs`
moodle3DB=`cat $moodle3CFG | grep '^$CFG->dbname' | cut -d "=" -f 2 | cut -d ';' -f 1 | xargs`
moodle3USER=`cat $moodle3CFG | grep '^$CFG->dbuser' | cut -d "=" -f 2 | cut -d ';' -f 1 | xargs`
moodle3PASS=`cat $moodle3CFG | grep '^$CFG->dbpass' | cut -d "=" -f 2 | cut -d ';' -f 1 | xargs`
