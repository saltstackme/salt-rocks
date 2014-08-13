
include:
  - cassandra_server.install

cassandra-stop:
  service:
    - dead
    - name: cassandra
    - require:
      - pkg: cassandra-install
