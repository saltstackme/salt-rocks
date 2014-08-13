include:
  - cassandra_server.install
  - cassandra_server.hosts
  - cassandra_server.configure
  - cassandra_server.start

exclude:
  - sls: hosts.all
  - sls: hosts.init

