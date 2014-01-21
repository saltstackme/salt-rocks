include:
  - python

uwsgi-install:
  pkg:
    - installed
    - pkgs:
      - uwsgi
      - uwsgi-plugin-python
  pip:
    - name: uwsgitop
    - installed
    - require:
      - pkg: uwsgi-install