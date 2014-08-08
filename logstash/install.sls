logstash-repo:
  pkgrepo.managed:
    - humanname: Logstash - Debian Repo
    - name: deb http://packages.elasticsearch.org/logstash/1.4/debian stable main
    - key_url: http://packages.elasticsearch.org/GPG-KEY-elasticsearch
    - require:
      - pkg: python-apt

logstash-jdk:
  pkg.installed:
    - name: openjdk-7-jre

logstash-pkg:
  pkg.installed:
    - name: logstash
    - require:
      - pkgrepo: logstash-repo
      - pkg: elasticsearch-jdk

