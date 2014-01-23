{% from "github_repo/files/map.jinja" import github_repo with context %}

user-group:
  group:
    - present
    - name: {{ github_repo.group }}
    - gid: {{ github_repo.gid }}

user-name:
  user:
    - present
    - name: {{ github_repo.username }}
    - fullname: {{ github_repo.fullname }}
    - shell: /bin/bash
    - uid: {{ github_repo.uid }}
    - groups:
        - {{ github_repo.group }}
    - require:
      - group: user-group

{% if github_repo.private %}
ssh-folder:
    file.directory:
    - name: /home/{{ github_repo.username }}/.ssh
    - user: {{ github_repo.username }}
    - group: {{ github_repo.group }}
    - dir_mode: 755
    - file_mode: 644
    - require:
      - user: user-name
      - group: user-group

github-key-file:
  file.managed:
    - name: /home/{{ github_repo.username }}/.ssh/{{ github_repo.rsa_key }}
    - source: 
      - salt://{{ github_repo.rsa_key_path }}/{{ github_repo.rsa_key }}
      - salt://github_repo/files/{{ github_repo.rsa_key }}
    - user: {{ github_repo.username }}
    - group: {{ github_repo.group }}    
    - mode: 600
    - require:
      - file: ssh-folder
{% endif %}