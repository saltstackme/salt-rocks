cron:
  pkg:
    - installed
    - name: {{ pillar['rocks']['package']['cron-pkg'] }}
  service:
    - running
    - name: {{ pillar['rocks']['package']['cron-service'] }}