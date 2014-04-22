include:
  - python

/usr/local/bin/uwsgi-pip-wrapper:
  file.managed:
    - source: salt://uwsgi/files/uwsgi-pip-wrapper
    - mode: 0655

uwsgi-installer:
  cmd.run:
    - name: /usr/local/bin/uwsgi-pip-wrapper
    - stateful: true
    - require:
      - pkg: mypkgs
      - file: /usr/local/bin/uwsgi-pip-wrapper
      - pkg: uwsgi-pkg-uninstalled

uwsgi-pkg-uninstalled:
  pkg:
    - absent
    - pkgs:
      - uwsgi
      - uwsgi-plugin-python

uwsgitop-install:
  pip:
    - name: uwsgitop
    - installed
    - require:
      - cmd: uwsgi-installer
