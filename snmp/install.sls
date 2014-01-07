snmp-install:
  pkg:
    - installed
    - name: {{ pillar['rocks']['package']['snmp-pkg'] }}
