#
#
# requires pillar data structed as seen below
# under salt-secret/cdn/base/pillar/secrets.sls
#
# cloudaccount:
#   rackspace_user: username
#   rackspace_key: 123123123123123123123123213
#   rackspace_account: 123456
#

curl:
  pkg:
    - installed

cdn.test-private-key:
  file:
    - managed
    - name: /root/.ssh/id_rsa
    - source: salt://jenkins_server/files/cdn.dev.id_rsa
    - mode: 600

cdn.test-public-key:
  file:
    - managed
    - name: /root/.ssh/id_rsa.pub
    - source: salt://jenkins_server/files/cdn.dev.id_rsa.pub
    - mode: 600

salt-installer-repo:
  git:
    - name : https://github.com/saltstackme/salt-vagrant.git
    - latest
    - rev: master
    - target: /root/salt-vagrant
    - force: True
    - require:
      - file: cdn.test-public-key
      - file: cdn.test-private-key

salt-installer-block-change:
  file:
    - blockreplace
    - name: /root/salt-vagrant/salt-installer.sh
    - marker_start: "######## begining of configuration ##############"
    - marker_end: "######## end of configuration ###################"
    - content: |
        PROVIDER="rackspace"
        VAGRANT_SERVER="remote"
        PREFIX="j-installer-build"
        INSTANCE_NAME="master"
        GITHUB_USERNAME="cdn.dev"
        GITHUB_EMAIL="atl.ops@lists.rackspace.com"
        RACKSPACE_USER="{{ pillar.cloudaccount.rackspace_user }}"
        RACKSPACE_KEY="{{ pillar.cloudaccount.rackspace_key }}"
        RACKSPACE_ACCOUNT="{{ pillar.cloudaccount.rackspace_account }}"
        RACKSPACE_REGION="iad"
        RACKSPACE_SSH_PUBLIC_KEY="cdn-dev-public-key"
        PROVIDER_PREFIX="auto-test"
        PROVIDER_IMAGES="ubuntu,centos"
        REPO="https://github.com/saltstackme/salt-sandbox.git"
    - show_changes: True
    - require:
      - git: salt-installer-repo
      - pkg: curl

salt-installer-block-change2:
  file:
    - blockreplace
    - name: /root/salt-vagrant/salt-installer.sh
    - marker_start: "######## deleting temporary server(s) #########"
    - marker_end: "echo == Deleting Vagrant Server"
    - content: |
        ssh -o "StrictHostKeyChecking no" root@${VAGRANT_SERVER} <<DELETEEOF
        cd /root/vagrant
        vagrant destroy ${PREFIX}-${INSTANCE_NAME}
        DELETEEOF
    - show_changes: True
    - require:
      - git: salt-installer-repo
      - pkg: curl
      - file: salt-installer-block-change

