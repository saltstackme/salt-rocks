{% from "memcached/files/map.jinja" import memcached with context %}

include:
  - memcached.configure

memcached-stop:
  service:
    - name: {{ memcached.srv }}
    - dead
