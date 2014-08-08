
elasticsearch-repo:
  pkgrepo.managed:
    - humanname: Elasticsearch - Debian Repo
    - name: deb http://packages.elasticsearch.org/elasticsearch/1.2/debian stable main
    - key_url: http://packages.elasticsearch.org/GPG-KEY-elasticsearch
    - require:
      - pkg: python-apt

python-apt:
  pkg.installed:
    - name: python-apt

elasticsearch-jdk:
  pkg.installed:
    - name: openjdk-7-jre

elasticsearch-pkg:
  pkg.installed:
    - name: elasticsearch 
    - require:
      - pkgrepo: elasticsearch-repo
      - pkg: elasticsearch-jdk

