#------------------------------------------------------------------------------
# Jenkins Master configuration
#------------------------------------------------------------------------------

# Creates SSH keypair for Jenkins user if one does not exist
jenkins_public_key:
  cmd.run:
    - name: su jenkins -c "ssh-keygen -f /var/lib/jenkins/.ssh/id_rsa -t rsa -N ''"
    - unless: test -f /var/lib/jenkins/.ssh/id_rsa.pub

set_public_key_grain:
  cmd.wait:
    - name: salt-call grains.setval jenkins_pub_key "`cat /var/lib/jenkins/.ssh/id_rsa.pub | cut -d' ' -f 2`"
    - watch:
      - cmd: jenkins_public_key

{% from "jenkins/files/pluginlist.jinja" import pluginlist with context %}
{% for plugin in pluginlist %}
{{ plugin }}:
  cmd.run:
    - cwd: /var/lib/jenkins/plugins
    - name: wget http://mirrors.jenkins-ci.org/plugins/{{ plugin }}/latest/{{ plugin }}.hpi
    - unless: test -d /var/lib/jenkins/plugins/{{ plugin }}
{% endfor %}

/var/lib/jenkins/hudson.model.UpdateCenter.xml:
  file.replace:
    - path: /var/lib/jenkins/hudson.model.UpdateCenter.xml
    - pattern: 'http:'
    - repl: 'https:'
#    - watch_in:
#      - service: jenkins
#      - reload: True

restart_jenkins:
  cmd.run:
    - name: service jenkins restart
