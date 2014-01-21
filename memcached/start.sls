{% from "memcached/files/map.jinja" import memcached with context %}

include:
  - memcached.configure

memcached-start:
  service:
    - name: {{ memcached.srv }}
    - running
    - enable: True
    - reload: True
    - watch:
        - file: memcached-configure
