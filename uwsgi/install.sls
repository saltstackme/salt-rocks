include:
  - python

uwsgi-install:
  pkg:
    - installed
    - pkgs:
      - uwsgi
      - uwsgi-plugin-python

uwsgitop:
  pip:
    - installed
    - require:
      - pkg: uwsgi-installer