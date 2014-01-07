snmp-stop:
  service:
    - name: {{ pillar['rocks']['package']['snmp-service'] }}
    - dead
