include:
  - emacs.install

emacs-configure:
  file:
    - managed
    - name: {{ pillar['rmap']['config']['emacs'] }}
    - source: salt://emacs/files/emacs.config
    - require:
      - pkg: emacs-install