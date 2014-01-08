{% from "snmp/files/map.jinja" import snmp with context %}

snmp-install:
  pkg:
    - installed
    - name: {{ snmp.pkg }}
