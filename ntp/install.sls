{% from "ntp/files/map.jinja" import ntp with context %}
{% from "ntp/files/map.jinja" import ntpdate with context %}

ntp-install:
  pkg:
    - name : {{ ntp.pkg }}
    - installed

ntpdate-install:
  pkg:
    - name: {{ ntpdate.pkg }}
    - installed