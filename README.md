USAO.moodle3
=========

Moodle 3.x for University of Science and Arts of Oklahoma.

Requirements
------------

CentOS 7.x
Apache
MariaDB

Role Variables
--------------

See defaults/main.yml

Dependencies
------------

```
- src: https://github.com/OULibraries/ansible-role-apache2
  version: v2016-10-17.0
  name: OULibraries.apache2

- src: https://github.com/OULibraries/ansible-role-centos7
  version: v2017-06-06.0
  name: OULibraries.centos7

- src: https://github.com/USAO/ansible-role-clamav
  version: master
  name: USAO.clamav

- src: https://github.com/OULibraries/ansible-role-mariadb
  version: v2016-09-26.0
  name: OULibraries.mariadb

- src: https://github.com/OULibraries/ansible-role-postfix-mta
  version: v2017-04-17.1
  name: OULibraries.postfix-mta

- src: https://github.com/OULibraries/ansible-role-users
  version: v2017-05-09.0
  name: OULibraries.users
```

Usage
-----

Does not touch crontab as described in the [docs](https://docs.moodle.org/33/en/Cron).

After installing, you need to edit apache's crontab
```
sudo crontab -u apache -e
```

And set your php to run cron for each Moodle site hosted on the system.
```
*/1 * * * * /opt/rh/rh-php71/root/bin/php  /srv/moodle/sitename/admin/cli/cron.php >/dev/null
```

Example Playbook
----------------

License
-------

[MIT](LICENSE)

Author Information
------------------

Jason Sherman
