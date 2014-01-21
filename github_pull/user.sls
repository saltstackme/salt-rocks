# supports one user
# create private key file under files/{{user.name}}.id_rsa

{% set github_user = {
    'name': 'my_user', 
    'fullname': 'github user',
    'mail': 'test@test.com',
    'group': 'my_group',
    'uid': 1001,
    'gid': 1001
    } 
%}


{% set user = salt['pillar.get']('github_user', 'github_user') %}

{{ user.group }}:
  group:
    - present
    - gid: {{ user.gid }}


{{ user.name }}:
  user:
    - present
    - fullname: {{ user.fullname }}
    - shell: /bin/bash
    - uid: {{ user.uid }}
    - groups:
        - {{ user.group }}
    - require:
      - group: {{ user.group }}
  ssh_auth:
    - present
    - user: {{ user.name }}
    - source: salt://github_pull/files/{{ user.name }}.id_rsa
    - require:
      - user: {{ user.name }}

{#
github_user:
    name: marconi
    fullname: marconi github user
    mail: test@test.com
    group: marconi
    uid: 1001
    gid: 1001
#}