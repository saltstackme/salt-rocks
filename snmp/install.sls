snmp-install:
  pkg:
    - installed
    - name: {{ pillar['rmap']['package']['snmp'] }}
