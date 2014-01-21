{% from "github_pull/files/map.jinja" import github_repo with context %}

include:
  - github_pull.user

pull-source:
  git:
    - name: {{ github_repo.url }}
    - latest
    - user: {{ github_repo.username }}
    - rev: {{ github_repo.rev }}
    - target: {{ github_repo.target }}
    - identity: /home/{{ github_repo.username }}/.ssh/{{ github_repo.username }}.id_rsa
    - require:
      - file: github-key-file
