include:
  - snmp.configure

snmp-disable:
  service:
    - name: {{ pillar['rocks']['package']['snmp-service'] }}
    - dead
    - enable: False
