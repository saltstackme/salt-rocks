{# toDo: zenoss needs to be started after everyhing is finished #}

{% if 'zenoss_installed' not in grains or grains['zenoss_installed'] != true %}

old-mysql-lib:
  pkg:
    - removed
    - name: mysql-libs

old-java-1.7:
  pkg:
    - removed
    - name: java-1.7.0-openjdk

old-java-1.6:
  pkg:
    - removed
    - name: java-1.6.0-openjdk

/etc/yum.repos.d/zenoss-core.repo:
  file:
    - managed
    - source: salt://zenoss/files/zenoss-core.repo

repos:
  pkg:
    - installed
    - enablerepo: zenoss-core
    - pkgs:
      - rpmforge-release
      - epel-release
    - require:
      - file: /etc/yum.repos.d/zenoss-core.repo

java:
  pkg:
    - installed
    - enablerepo: zenoss-core
    - name: jre
    - require:
      - file: /etc/yum.repos.d/zenoss-core.repo
      - pkg: old-java-1.7
      - pkg: old-java-1.6
  cmd:
    - run
    - name: echo 'export JAVA_HOME=/usr/java/default' >> /etc/profile
    - require:
      - pkg: java
    
rrdtool:
  pkg:
    - installed
    - enablerepo: rpmforge-extras
    - require:
      - pkg: repos
    
rabbitmq-server:
  pkg:
    - installed
    - enablerepo: epel,zenoss-core
    - require:
      - pkg: repos
      - file: /etc/yum.repos.d/zenoss-core.repo
  service:
    - running
    - enable: True
    - require:
      - pkg: rabbitmq-server

mysql:
  pkg:
    - installed
    - enablerepo: zenoss-core
    - pkgs:
      - MySQL-server
      - MySQL-client
      - MySQL-shared
    - require:
      - pkg: repos
      - pkg: old-mysql-lib
  file:
    - managed
    - name: /etc/my.cnf
    - source: salt://zenoss/files/my.cnf
    - require:
      - pkg: mysql
{% if 'zenoss_role' in grains and grains['zenoss_role'] == 'master' %}
  service:
    - running
    - enable: True
    - require:
      - pkg: mysql
{% endif %}

zenoss:
  pkg:
    - installed
    - enablerepo: epel,zenoss-core
    - require:
      - file: /etc/yum.repos.d/zenoss-core.repo
      - pkg: repos
      - pkg: rabbitmq-server
      - pkg: rrdtool
      - pkg: mysql
  file:
    - managed
    - name: /opt/zenoss/etc/global.conf
    - source: salt://zenoss/files/global.conf
    - require:
      - pkg: zenoss
{% if 'zenoss_role' in grains and grains['zenoss_role'] == 'master-disabled' %}
  service:
    - running
    - enable: True
    - require:
      - pkg: zenoss
      - service: mysql
      - service: memcached
      - service: rabbitmq-server
{% endif %}

/opt/zenoss/bin/set-rabbitmq-perms.sh:
  file:
    - managed
    - mode: 755
    - source: salt://zenoss/files/set-rabbitmq-perms.sh
    - require:
      - pkg: zenoss
  cmd:
    - run
    - require:
      - file: /opt/zenoss/bin/set-rabbitmq-perms.sh
      - service: rabbitmq-server
      - pkg: zenoss

{# zenoss pkg will install these anyways
but good to verify if they are installed
before starting them #}
zenoss-requires:
  pkg:
    - installed
    - pkgs:
      - memcached
      - net-snmp
    - require:
      - pkg: zenoss

{% for my_service in 'memcached','snmpd', %}
{{ my_service }}:
  service:
    - running
    - enable: True
    - require:
      - pkg: zenoss-requires
{% endfor %}

{# toDo: memcached configuration file #}
{# toDo: start zenoss only if master #}

zenoss_installed:
  grains:
    - present
    - value: True
    - require:
      - pkg: zenoss


{# todo secure mysql and zenoss installation #}

{% if 'zenoss_role' in grains and grains['zenoss_role'] == 'master' %}
{# todo: check if we need dependencies to copy keys #}
/home/zenoss/.ssh/id_rsa:
  file:
    - managed
    - user: zenoss
    - group: zenoss
    - mode: 600
    - source: salt://zenoss/files/zenoss-id_rsa

/home/zenoss/.ssh/id_rsa.pub:
  file:
    - managed
    - user: zenoss
    - group: zenoss
    - mode: 600
    - source: salt://zenoss/files/zenoss-id_rsa.pub
{% endif %}

{% if 'zenoss_role' in grains and grains['zenoss_role'] == 'collector' %}
/home/zenoss/.ssh:
  file:
    - directory
    - user: zenoss
    - group: zenoss
    - mode: 700
    - require:
      - pkg: zenoss

zenoss-ssh:
  ssh_auth:
    - present
    - name: zenoss
    - user: zenoss
    - source: salt://zenoss/files/zenoss-id_rsa.pub
    - require:
      - pkg: zenoss

/opt/zenoss/var/zenpack_actions.txt:
  file:
    - absent
{% endif %}

{% endif %}

