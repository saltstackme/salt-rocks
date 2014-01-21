include:
  - nginx.configure

nginx-start:
  service:
    - name: nginx
    - running
    - enable: True
    - reload: True
    - watch:
      - file: nginx-configure
