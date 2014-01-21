{% from "memcached/files/map.jinja" import memcached with context %}

include:
  - ntp.memcached

memcached-disable:
  service:
    - name: {{ memcached.srv }}
    - dead
    - enable: False
