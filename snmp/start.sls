{% from "files/map.jinja" import snmp with context %}

include:
  - snmp.configure

snmp-start:
  service:
    - name: {{ snmp.srv }}
    - running
    - enable: True
    - reload: True
    - watch:
        - file: snmp-configure
