{% from "github_repo/files/map.jinja" import github_repo with context %}

{{ github_repo.group }}:
  group:
    - present
    - gid: {{ github_repo.gid }}

{{ github_repo.username }}:
  user:
    - present
    - fullname: {{ github_repo.fullname }}
    - shell: /bin/bash
    - uid: {{ github_repo.uid }}
    - groups:
        - {{ github_repo.group }}
    - require:
      - group: {{ github_repo.group }}

{% if github_repo.private %}
ssh-folder:
    file.directory:
    - name: /home/{{ github_repo.username }}/.ssh
    - user: {{ github_repo.username }}
    - group: {{ github_repo.group }}
    - dir_mode: 755
    - file_mode: 644
    - require:
      - user: {{ github_repo.username }}

github-key-file:
  file.managed:
    - name: /home/{{ github_repo.username }}/.ssh/{{ github_repo.username }}.id_rsa
    - source: salt://github_repo/files/{{ github_repo.username }}.id_rsa
    - user: {{ github_repo.username }}
    - group: {{ github_repo.group }}    
    - mode: 600
    - require:
      - file: ssh-folder
{% endif %}