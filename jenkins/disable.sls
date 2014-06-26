{% from "jenkins/files/map.jinja" import jenkins with context %}

jenkins-disable:
  service.dead:
    - name: {{ jenkins.srv }}
    - enable: False
