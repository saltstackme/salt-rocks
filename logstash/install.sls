logstash-pre-req:
  pkg.installed:
    - name: python-apt

logstash-repo:
  pkgrepo.managed:
    - humanname: Logstash - Debian Repo
    - name: deb http://packages.elasticsearch.org/logstash/1.4/debian stable main
    - key_url: http://packages.elasticsearch.org/GPG-KEY-elasticsearch
    - require:
      - pkg: logstash-pre-req

logstash-jdk:
  pkg.installed:
    - name: openjdk-7-jre

logstash-pkg:
  pkg.installed:
    - name: logstash
    - require:
      - pkgrepo: logstash-repo
      - pkg: logstash-jdk

