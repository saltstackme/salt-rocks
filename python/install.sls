{% from "python/files/map.jinja" import python-dev with context %}
{% from "python/files/map.jinja" import python-pip with context %}
{% from "python/files/map.jinja" import build-essential with context %}

python-install:
  pkg:
    - installed
    - pkgs:
      - git
      - {{ python-dev.pkg }}
      - {{ python-pip.pkg }}
      - {{ build-essential.pkg }}