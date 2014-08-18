#------------------------------------------------------------------------------
# Runs on all slaves
#------------------------------------------------------------------------------

# Install default Java JRE
default-jre:
  pkg.installed

# Create user account for Jenkins
jenkins-user:
  user.present:
    - name: jenkins
    - fullname: Jenkins
    - shell: /bin/bash

# Seed the authorized_keys with the public key from the Jenkins master
{%- for value in salt['mine.get']('G@jenkins_type:master and G@environment_id:' + grains['environment_id'], 'grains.items', expr_form='compound').values() %}
{{ value['jenkins_pub_key'] }}:
  ssh_auth:
    - present
    - user: jenkins
    - enc: ssh-rsa
    - comment: jenkins
    - require:
      - user: jenkins-user

/home/jenkins/.ssh/id_rsa:
  file.managed:
    - user: jenkins
    - group: jenkins
    - mode: 600
    - source: salt://jenkins/files/id_rsa
    - template: jinja
    - require:
      - user: jenkins-user
{%- endfor %}

git-preauth:
  cmd.run:
    - name: ssh -o StrictHostKeyChecking=no -T git@github.com || true
    - user: jenkins
    - group: jenkins
    - require:
      - file: /home/jenkins/.ssh/id_rsa
