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

ssh-folder:
    file.directory:
    - name: /home/{{ github_user.name }}/.ssh
    - user: {{ github_user.name }}
    - group: {{ github_user.group }}
    - dir_mode: 755
    - file_mode: 644
    - require:
      - user: {{ github_user.name }}

key-file:
  file.managed:
    - name: /home/{{ github_user.name }}/.ssh/{{ github_user.name }}.id_rsa
    - source: salt://github_pull/files/{{ github_user.name }}.id_rsa
    - user: {{ github_user.name }}
    - group: {{ github_user.group }}    
    - mode: 600
    - require:
      - file: ssh-folder

