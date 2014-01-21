{% from "memcached/files/map.jinja" import memcached with context %}

memcached-install:
  pkg:
    - name : {{ memcached.pkg }}
    - installed
