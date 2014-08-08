include:
    - logstash.install

logstash-stop:
  service:
    - dead
    - name: logstash
    - enable: False

