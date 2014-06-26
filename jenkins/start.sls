{% from "jenkins/files/map.jinja" import jenkins with context %}

jenkins-start:
  service.running:
    - name: {{ jenkins.srv }}
    - enable: True
    - reload: True
