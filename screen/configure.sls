/root/.screenrc:
  file:
    - managed
    - source: salt://screen/files/screenrc.config
    - require:
      - pkg: screen