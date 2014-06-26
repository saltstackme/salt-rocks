{% from "jenkins/files/map.jinja" import jenkins with context %}

jenkins-stop:
  service.dead:
    - name: {{ jenkins.srv }}
