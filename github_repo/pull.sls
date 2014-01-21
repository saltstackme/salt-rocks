{% from "github_repo/files/map.jinja" import github_repo with context %}

include:
  - github_repo.user

git-install:
  pkg.installed
    - name: git

pull-source:
  git:
    - name: {{ github_repo.url }}
    - latest
    - user: {{ github_repo.username }}
    - rev: {{ github_repo.rev }}
    - target: {{ github_repo.target }}
    {% if github_repo.private %}
    - identity: /home/{{ github_repo.username }}/.ssh/{{ github_repo.rsa_key }}
    - require:
      - file: github-key-file
    {% endif %}
    require:
      - pkg: git-install
