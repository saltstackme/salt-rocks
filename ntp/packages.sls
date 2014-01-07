ntp:
  pkg:
    - installed
  service:
    - name: {{ pillar['rocks']['package']['ntp'] }}
    - running
    - enable: True
    - require:
      - pkg: ntp