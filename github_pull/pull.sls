include:
  - github_pull.user

billing_queues-source:
  git:
    - name: 'git@github.com:rackerlabs/billing_queues.git'
    - latest
    - rev: {{ pillar['billing_queues_version'] }}
    - target: /tmp/billing_queues
    - identity: /root/.ssh/id_devopsatlpull_rsa
    - require:
      - file: /root/.ssh/id_devopsatlpull_rsa
      - cmd: billing_queues-cleanup
      - pip: billing_queues-cleanup