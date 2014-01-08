{% from "cron/files/map.jinja" import cron with context %}

include:
  - cron.configure

cron-start:
  service:
    - name: {{ cron.srv }}
    - running
    - enable: True
    - reload: True
