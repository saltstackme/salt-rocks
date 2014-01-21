{% from "github_pull/files/map.jinja" import github_user with context %}

{{ github_user.group }}:
  group:
    - present
    - gid: {{ github_user.gid }}


{{ github_user.name }}:
  user:
    - present
    - fullname: {{ github_user.fullname }}
    - shell: /bin/bash
    - uid: {{ github_user.uid }}
    - groups:
        - {{ github_user.group }}
    - require:
      - group: {{ github_user.group }}
  ssh_auth:
    - present
    - user: {{ github_user.name }}
    - source: salt://github_pull/files/{{ github_user.name }}.id_rsa
    - require:
      - user: {{ github_user.name }}
