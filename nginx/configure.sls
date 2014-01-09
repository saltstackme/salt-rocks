include:
  - nginx.install

nginx-configure:
  file:
    - managed
    - name: /etc/nginx/nginx.conf
    - source: salt://nginx/files/nginx.conf
    - require:
      - pkg: nginx-install
