{% from "cron/files/map.jinja" import cron with context %}

include:
  - cron.configure

cron-stop:
  service:
    - name: {{ cron.srv }}
    - dead
