{% from "snmp/files/map.jinja" import snmp with context %}

snmp-install:
  pkg:    
    - name: {{ snmp.pkg }}
    - installed
