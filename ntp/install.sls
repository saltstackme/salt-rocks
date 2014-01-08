{% from "ntp/files/map.jinja" import ntp with context %}

ntp-install:
  pkg:
    - name : {{ ntp.pkg }}
    - installed