{% from "cassandra/files/map.jinja" import cassandra with context %}

include:
  - cassandra_server.install


cassandra_config:
  file.managed:
    - name: /etc/cassandra/cassandra.yaml
    - source: salt://cassandra_server/files/cassandra.yaml
    - template: jinja
    - require:
      - pkg: cassandra-install

cassandra_topology:
  file.managed:
    - name: /etc/cassandra/cassandra-topology.properties
    - source: salt://cassandra_server/files/cassandra-topology.properties
    - template: jinja
    - require:
      - pkg: cassandra-install
