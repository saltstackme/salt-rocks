{% from "snmp/files/map.jinja" import snmp with context %}

include:
  - snmp.install

snmp-configure:
  file:
    - managed
    - name: {{ snmp.conf }}
    - source: salt://snmp/files/snmp.conf
    - require:
      - pkg: snmp-install
