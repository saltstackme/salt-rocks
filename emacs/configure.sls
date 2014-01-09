{% from "emacs/files/map.jinja" import emacs with context %}

include:
  - emacs.install

emacs-configure:
  file:
    - managed
    - name: {{ emacs.conf }}
    - source: salt://emacs/files/emacs.config
    - require:
      - pkg: emacs-install
