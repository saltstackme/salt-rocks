cassandra-user:
   service.running:
     - name: cassandra
   cmd.run:
     - name: |
        cqlsh -u cassandra -p cassandra -e "ALTER KEYSPACE system_auth WITH REPLICATION ={ 'class' : 'SimpleStrategy', 'replication_factor' : 3 };"
        cqlsh -u cassandra -p cassandra -e "CREATE USER {{ salt['pillar.get']('secrets:cassandra:client:user', 'secretuser') }} WITH PASSWORD '{{ salt['pillar.get']('secrets:cassandra:client:password', 'secretpassword') }}' SUPERUSER;"
        cqlsh -u {{ salt['pillar.get']('secrets:cassandra:client:user', 'secretuser') }} -p {{ salt['pillar.get']('secrets:cassandra:client:password', 'secretpassword') }} -e "DROP USER cassandra;"
     - require:
       - service: cassandra-user
