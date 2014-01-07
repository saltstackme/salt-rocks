include:
  - snmp.configure

snmp-start:
  service:
    - name: {{ pillar['rmap']['service']['snmp'] }}
    - running
    - enable: True
    - reload: True
    - watch:
        - file: snmp-configure
