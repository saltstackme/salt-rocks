include:
  - nginx.configure

nginx-disable:
  service:
    - name: nginx
    - dead
    - enable: False
