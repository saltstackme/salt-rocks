{% from "python/files/map.jinja" import python with context %}

python-install:
  pkg:
    - installed
    - pkgs:
      - git
      - {{ python.python-dev }}
      - {{ python.python-pip }}
      - {{ python.build-essential }}