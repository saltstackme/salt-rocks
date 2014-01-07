/root/.emacs:
  file:
    - managed
    - source: salt://emacs/files/emacs.config
    - require:
      - pkg: emacs