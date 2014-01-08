{% from "cron/files/map.jinja" import cron with context %}

include:
  - cron.configure

cron-disable:
  service:
    - name: {{ cron.srv }}
    - dead
    - enable: False
