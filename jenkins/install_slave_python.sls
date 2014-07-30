# Python slave install
mine.update:
  module.run

build-tools:
  pkg.installed:
    - pkgs:
      - python-virtualenv
      - python-pip
      - python-dev
      - freetds-dev
      - python-software-properties

{%- if grains['os'] == "Ubuntu" %}
# PPA to install older versions of Python on
# Ubuntu servers
deadsnakes:
  pkgrepo.managed:
    - humanname: Deadsnakes PPA
    - ppa: fkrull/deadsnakes
  pkg.installed:
    - pkgs:
      - python3.4
      - python3.4-dev
      - python3.3
      - python3.3-dev
      - python2.7
      - python2.7-dev
      - python2.6
      - python2.6-dev
    - require:
      - pkgrepo: deadsnakes
{%- endif %}


