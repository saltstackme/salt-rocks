include:
    - logstash.install


logstash-start:
  service:
    - running
    - name: logstash
    - enable: True
