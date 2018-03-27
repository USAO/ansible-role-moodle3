#!/usr/bin/env bash

PATH=/opt/usao/moodle3/bin:/usr/local/bin:/usr/bin:/bin:/sbin:$PATH

source /opt/usao/moodle3/etc/moodle3_conf.sh

sudo -u apache bash -c "\
source scl_source enable rh-php71; \
php ${moodle3DIR}/admin/cli/purge_caches.php; \
php ${moodle3DIR}/admin/cli/mysql_compressed_rows.php --fix; \
php ${moodle3DIR}/admin/cli/maintenance.php --enable; \
php ${moodle3DIR}/admin/cli/upgrade.php --non-interactive; \
php ${moodle3DIR}/admin/cli/maintenance.php --disable; \
"
