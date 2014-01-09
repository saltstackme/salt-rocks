{% from "python/files/map.jinja" import python_dev with context %}
{% from "python/files/map.jinja" import python_pip with context %}
{% from "python/files/map.jinja" import build_essential with context %}

python-install:
  pkg:
    - installed
    - pkgs:
      - git
      - {{ python_dev.pkg }}
      - {{ python_pip.pkg }}
      - {{ build_essential.pkg }}