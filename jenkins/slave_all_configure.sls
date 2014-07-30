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
{%- for value in salt['mine.get']('jenkins_type:master', 'grains.items', expr_form='grain').values() %}
{{ value['jenkins_pub_key'] }}:
  ssh_auth:
    - present
    - user: jenkins
    - enc: ssh-rsa
    - comment: jenkins
    - require:
      - user: jenkins-user
{%- endfor %}
