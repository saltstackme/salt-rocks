{% from "ntp/files/map.jinja" import ntp with context %}

include:
  - ntp.install

# toDo: have configuration file is ubuntu specific
ntp-configure:
  file:
    - managed
    - name: {{ ntp.conf }}
    - source: salt://ntp/files/ntp.conf
    - require:
      - pkg: ntp-install
