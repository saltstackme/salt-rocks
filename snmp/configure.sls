include:
  - snmp.install

snmp-configure:
  file:
    - managed
    - name: {{ pillar['rmap']['package']['snmp'] }}
    - source: salt://snmp/files/snmp.conf
    - require:
      - pkg: snmp-install
