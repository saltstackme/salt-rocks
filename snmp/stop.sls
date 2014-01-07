snmp-stop:
  service:
    - name: {{ pillar['rmap']['service']['snmp'] }}
    - dead
