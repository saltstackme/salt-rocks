{% from "cassandra/files/map.jinja" import cassandra with context %}

cassandra_config:
  file.managed:
    - name: /etc/cassandra/cassandra.yaml
    - source: salt://cassandra/files/cassandra.yaml
    - template: jinja
    - require:
      - pkg: cassandra-install
    - watch_in:
      - service: cassandra-start
    - defaults:
        password: {{ salt['pillar.get']('secrets:cassandra:password', 'cassandra') }}
        server_encryption: all
        client_encryption: True

cassandra_topology:
  file.managed:
    - name: /etc/cassandra/cassandra-topology.properties
    - source: salt://cassandra/files/cassandra-topology.properties
    - template: jinja
    - require:
      - pkg: cassandra-install

cassandra_gossipfile:
  file.managed:
    - name: /etc/cassandra/cassandra-rackdc.properties
    - source: salt://cassandra/files/cassandra-rackdc.properties
    - template: jinja
    - require:
      - pkg: cassandra-install

cassandra_keystore:
  file.managed:
    - name: /etc/cassandra/.keystore
    - source: salt://cassandra/files/keystore
    - requre:
       - pkg: cassandra-install

cassandra_truststore:
  file.managed:
    - name: /etc/cassandra/.truststore
    - source: salt://cassandra/files/truststore
    - requre:
       - pkg: cassandra-install

{%- if salt["grains.get"]('cassandra_initialized', 'False') != 'True' %}
{%- do salt['grains.setval']('cassandra_initialized', 'True') %}
# Initialize System, we need to start with a blank database
cassandra-init:
  cmd.run:
    - name: "service cassandra stop;rm -rf /var/lib/cassandra/*;touch /etc/cassandra/initialized"
    - require:
      - file: cassandra_config
      - file: cassandra_topology
      - file: cassandra_gossipfile
      - file: cassandra_keystore
      - file: cassandra_truststore
      - pkg: cassandra-install
{%- endif %}

cassandra-cqlshrc:
  file.managed:
    - name: /root/.cassandra/cqlshrc
    - source: salt://cassandra/files/cqlshrc
    - makedirs: true
