include:
    - memcached

{% for pkg in 'build-essential', 'python-dev', 'python-pip', 'sqlite', 'libcairo2',
'libcairo2-dev', 'python-cairo', 'pkg-config', 'git' %}
{{ pkg }}:
  pkg.installed
{% endfor %}

{% for pypkg in 'django==1.4.10', 'python-memcached', 'django-tagging', 'Twisted<12.0',
'whisper==0.9.10', 'carbon==0.9.10' %}
{{ pypkg }}:
  pip.installed
{% endfor %}

graphite_pkg:
    pip.installed:
      - name: graphite-web==0.9.10

/opt/graphite/storage/log/webapp:
    file.directory:
        - require:
            - pip: graphite_pkg

# configs
/opt/graphite/conf/storage-schemas.conf:
    file.managed:
        - source: salt://graphite/files/storage-schemas.conf
        - require:
            - pip: graphite_pkg

/opt/graphite/conf/carbon.conf:
    file.managed:
        - source: salt://graphite/files/carbon.conf
        - require:
            - pip: graphite_pkg

carbon_init:
   file.managed:
      - name: /etc/init.d/carbon
      - source: salt://graphite/files/carbon-init
      - mode: 0655
      - require:
        - pip: graphite_pkg

carbon_service:
    service:
        - name: carbon
        - running
        - require:
            - pip: graphite_pkg

# Apache-wsgi

{% for pkg in 'apache2', 'apache2-mpm-worker', 'apache2-utils', 'apache2.2-bin', 'libapr1', 'libaprutil1', 'libaprutil1-dbd-sqlite3', 'python3', 'libpython3.2', 'python3-minimal', 'libapache2-mod-wsgi', 'libaprutil1-ldap', 'python-cairo-dev', 'python-django', 'python-ldap', 'sqlite3', 'erlang-os-mon', 'erlang-snmp', 'rabbitmq-server', 'bzr', 'expect', 'libapache2-mod-python', 'python-setuptools' %}
{{ pkg }}:
  pkg.installed
{% endfor %}

{% for pypkg in 'zope.interface', 'twisted', 'txamqp' %}
{{ pypkg }}:
  pip.installed
{% endfor %}

webapp_config:
    cmd.wait:
        - name: python manage.py syncdb --noinput
        - cwd: /opt/graphite/webapp/graphite
        - watch:
            - pip: graphite_pkg

/opt/graphite/webapp/graphite/local_settings.py:
    file.managed:
        - source: salt://graphite/files/local_settings.py
        - require:
            - pip: graphite_pkg

/etc/apache2/sites-available/graphite:
    file.managed:
        - source: salt://graphite/files/graphite-vhost.conf
        - require:
            - pip: graphite_pkg
            - pkg: apache2

/opt/graphite/conf/graphite.wsgi:
    file.managed:
        - source: salt://graphite/files/graphite.wsgi
        - require:
            - pip: graphite_pkg

/opt/graphite/bin/set_admin_passwd.py:
    file.managed:
        - source: salt://graphite/files/set_admin_passwd.py
        - mode: 655
        - require:
            - pip: graphite_pkg
    cmd.wait:
        - name: /opt/graphite/bin/set_admin_passwd.py admin
        - cwd: /opt/graphite/webapp/graphite
        - watch:
            - file: /opt/graphite/bin/set_admin_passwd.py

/var/run/wsgi:
    file.directory

/opt/graphite/storage:
    file.directory:
        - user: www-data
        - group: www-data
        - recurse:
            - user
            - group
        - require:
            - pip: graphite_pkg
            - pkg: apache2

vhost_enable:
    cmd.wait:
        - name: a2dissite default && a2ensite graphite && apachectl restart
        - watch:
            - file: /etc/apache2/sites-available/graphite

apache2_service:
    service:
        - name: apache2
        - running
        - require:
            - pip: graphite_pkg
            - pkg: apache2
