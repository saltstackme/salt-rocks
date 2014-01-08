{% from "ntp/files/map.jinja" import ntp with context %}

include:
  - ntp.configure

ntp-start:
  service:
    - name: {{ ntp.srv }}
    - running
    - enable: True
    - reload: True
    - watch:
        - file: ntp-configure
