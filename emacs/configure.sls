{% from "snmp/files/map.jinja" import snmp with context %}

include:
  - emacs.install

emacs-configure:
  file:
    - managed
    - name: {{ emacs.conf }}
    - source: salt://emacs/files/emacs.config
    - require:
      - pkg: emacs-install
