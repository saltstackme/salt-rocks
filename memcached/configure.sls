{% from "memcached/files/map.jinja" import memcached with context %}

include:
  - memcached.install

memcached-configure:
  file:
    - managed
    - name: {{ memcached.conf }}
    - source: salt://memcached/files/memcached.conf
    - require:
      - pkg: memchaced-install
