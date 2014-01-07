include:
  - snmp.install

snmp-configure:
  file:
    - managed
    - name: {{ pillar['rocks']['package']['snmp-conf'] }}
    - source: salt://snmp/files/snmp.conf
    - require:
      - pkg: snmp-install
