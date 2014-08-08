include:
    - logstash.install

elasticsearch-stop:
  service:
    - dead
    - name: elasticsearch
    - enable: False

