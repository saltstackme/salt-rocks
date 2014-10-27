# zenoss_server formula

## Files

### Formula Files
* fingerprints.sls
* hosts.sls
* init.sls
* install.sls
* render.sls

### Templates
* global.conf
* my.cnf
* set-rabbitmq-perms.sh
* status.jinja
* zenoss-core.repo

### Requirements that are private
* zenoss-id_rsa
* zenoss-id_rsa.pub

## Related Grains

* server_role: zenoss_server
* zenoss_role: master | collector
* zenoss_installed: true | false

## Formula Details

### hosts.sls
Adds all zenoss servers to hosts file

### install.sls
Installs zenoss and related packages. Takes different actions based on zenoss server being a master or collector.

### render.sls
Fixes remote collector graph display problem. This has to run after zenoss is installed on the server and it is added as remote collector via the web interface on master server using "remote collector" zenpack.

### fingerprints.sls
Adds zenoss collectors ssh host key fingerprint to known_hosts on zenoss master  for zenoss user. This needs to run after a collector is installed but before it is added to master as remote collector. Otherwise, zenoss master won't be able to ssh for the first time and won't be able to configure remote collector / monitor

### Run Order

#### on collector

    rpm -e --nodeps mysql-libs-5.1.69-1.el6_4.x86_64


#### installing zenoss collector with salt, on master

    salt 'zenc1-cbp-syd' grains.setval environment_id rcbu-prod-syd
    salt 'zenc1-cbp-syd' grains.setval roles zenoss_server
    salt 'zenc1-cbp-syd' grains.setval zenoss_role collector

    salt 'zenc1-cbp-hkg' state.sls minion rcbu-prod-hkg
    salt 'zenc1-cbp-hkg' state.sls zenoss_server.install rcbu-prod-hkg

#### on master

    salt 'zenm1-cbp-syd' state.sls zenoss_server.hosts rcbu-prod-hkg
    salt 'zenm1-cbp-ord' state.sls zenoss_server.fingerprints rcbu-prod-ord

#### graph part

Modify /opt/zenoss/etc/daemons.txt
   add zenrender
