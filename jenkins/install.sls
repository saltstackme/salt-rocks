{% from "jenkins/files/map.jinja" import jenkins with context %}

jenkins-install:
  pkg.installed:
    - name: {{ jenkins.pkg }}

jenkins-repo:
  pkg.installed:
    - name: python-apt
  pkgrepo.managed: 
    - name: deb http://pkg.jenkins-ci.org/debian binary/
    - key_url: http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key
    - require: 
      - pkg: python-apt
    - require_in: 
      - pkg: jenkins

