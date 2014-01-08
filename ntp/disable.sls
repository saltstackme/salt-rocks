{% from "ntp/files/map.jinja" import ntp with context %}

include:
  - ntp.configure

ntp-disable:
  service:
    - name: {{ ntp.srv }}
    - dead
    - enable: False
