ntp:
  pkg:
    - installed
  service:
    - name: {{ pillar['rmap']['package']['ntp'] }}
    - running
    - enable: True
    - require:
      - pkg: ntp