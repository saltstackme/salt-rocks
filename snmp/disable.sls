{% from "snmp/files/map.jinja" import snmp with context %}

include:
  - snmp.configure

snmp-disable:
  service:
    - name: {{ snmp.srv }}
    - dead
    - enable: False
