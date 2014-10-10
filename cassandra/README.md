TODO: More Instructions

Grains that need to be set:
* cassandra_project: This is the project
* cassandra_seed: True or False

Special Pillars
==========
* secrets:cassandra:client:user - This is the default superuser username
* secrets:cassandra:client:password - This is the default superuser password
* secrets:cassandra:password - This is the password used to access trust store and keystore for internodal access

Required Files for Encryption
==========
* keystore - Used to hold certificate and key
* truststore - Holds the signed certificate
* secrets - holds the above Pillar information

