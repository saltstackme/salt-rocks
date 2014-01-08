{% from "cron/files/map.jinja" import cron with context %}

cron-install:
  pkg:    
    - name: {{ cron.pkg }}
    - installed
