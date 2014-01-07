cron:
  pkg:
    - installed
    - name: {{ pillar['rmap']['package']['cron'] }}
  service:
    - running
    - name: {{ pillar['rmap']['service']['cron'] }}