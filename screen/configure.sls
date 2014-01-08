screen-configure:
  file:
    - managed
    - name: /root/.screenrc
    - source: salt://screen/files/screenrc.config
    - require:
      - pkg: screen