USAO.moodle3
=========

Moodle 3.x for University of Science and Arts of Oklahoma

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

Example Playbook
----------------

License
-------

[MIT](LICENSE)

Author Information
------------------

Jason Sherman
