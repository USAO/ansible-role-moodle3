## Read useful values out of the config file
moodle3PARENT=`dirname ${1}`
moodle3DIR=`find ${1} -maxdepth 1 -type d -name 'moodle-3[0-9]' | sort | tail -1`
moodle3CFG=${moodle3DIR}/config.php
moodle3DBHOST=`cat $moodle3CFG | grep '^$CFG->dbhost' | cut -d "=" -f 2 | cut -d ';' -f 1 | xargs`
moodle3DB=`cat $moodle3CFG | grep '^$CFG->dbname' | cut -d "=" -f 2 | cut -d ';' -f 1 | xargs`
moodle3USER=`cat $moodle3CFG | grep '^$CFG->dbuser' | cut -d "=" -f 2 | cut -d ';' -f 1 | xargs`
moodle3PASS=`cat $moodle3CFG | grep '^$CFG->dbpass' | cut -d "=" -f 2 | cut -d ';' -f 1 | xargs`
moodle3wwwroot=`cat $moodle3CFG | grep '^$CFG->wwwroot' | cut -d "=" -f 2 | cut -d ';' -f 1 | xargs`
