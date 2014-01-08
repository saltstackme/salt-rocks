{% from "snmp/files/map.jinja" import snmp with context %}

include:
  - snmp.configure

snmp-stop:
  service:
    - name: {{ snmp.srv }}
    - dead
