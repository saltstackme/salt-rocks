include:
  - snmp.configure

snmp-disable:
  service:
    - name: {{ pillar['rmap']['package']['snmp'] }}
    - dead
    - enable: False
