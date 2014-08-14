# Jenkins Master install

# We need to make sure the custom state module is loaded on the minion before we can run the github states.
saltutil.sync_all:
  module.run

# This pip module is required for the github state module to work.
github3.py:
  pip.installed

{% from "jenkins/files/map.jinja" import jenkins with context %}

jenkins-install:
  pkg.installed:
    - name: {{ jenkins.pkg }}
    - require:
      - pkgrepo: jenkins-repo

jenkins-repo:
  pkg.installed:
    - name: python-apt
  pkgrepo.managed:
    - name: deb http://pkg.jenkins-ci.org/debian binary/
    - key_url: http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key
    - require:
      - pkg: python-apt

