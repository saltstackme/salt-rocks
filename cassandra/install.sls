apt-python-pkg:
  pkg.installed:
    - name: python-apt

java-installed:
  pkg.installed:
    - name: openjdk-7-jre

cassandra-repo:
  pkgrepo.managed:
    - humanname: Apache Cassandra Repo
    - name: deb http://www.apache.org/dist/cassandra/debian 20x main
    - file: /etc/apt/sources.list.d/cassandra.list
    - keyid: 2B5C1B00
    - keyserver: pgp.mit.edu
    - require:
      - pkg: apt-python-pkg

cassandra-install:
  pkg.installed:
    - name: cassandra
    - require:
      - pkg: java-installed
      - pkgrepo: cassandra-repo

# Initialize System, we need to start with a blank database
cassandra-init:
  service.dead:
    - name: cassandra
    - unless: "stat /etc/cassandra/initialized"
  cmd.run:
    - name: "rm -rf /var/lib/cassandra/*;touch /etc/cassandra/initialized"
    - unless: "stat /etc/cassandra/initialized"

