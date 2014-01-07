include:
  - snmp.configure

snmp-start:
  service:
    - name: {{ pillar['rocks']['package']['snmp-service'] }}
    - running
    - enable: True
    - reload: True
    - watch:
        - file: snmp-configure
