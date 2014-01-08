{% from "ntp/files/map.jinja" import ntp with context %}

include:
  - ntp.configure

ntp-stop:
  service:
    - name: {{ ntp.srv }}
    - dead
