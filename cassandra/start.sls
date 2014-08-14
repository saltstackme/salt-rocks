include:
  - cassandra.install

cassandra-start:
  service:
    - running
    - name: cassandra
    - enable: True
    - require:
      - pkg: cassandra-install

