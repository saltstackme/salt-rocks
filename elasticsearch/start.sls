include:
    - elasticsearch.install


elasticsearch-start:
  service:
    - running
    - name: elasticsearch
    - enable: True
