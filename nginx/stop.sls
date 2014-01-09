include:
  - nginx.configure

nginx-stop:
  service:
    - name: nginx
    - dead
