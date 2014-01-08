{% from "emacs/files/map.jinja" import emacs with context %}

emacs-install:
  pkg:    
    - name: {{ emacs.pkg }}
    - installed
