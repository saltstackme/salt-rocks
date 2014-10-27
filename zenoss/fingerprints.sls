#
# Adds zenoss collectors ssh host key fingerprint to known_hosts on zenoss master
# for zenoss user
# This needs to run after a collector is installed but before it is added to master
# as remote collector.
# Otherwise, zenoss master won't be able to ssh for the first time and won't
# be able to configure remote collector / monitor
#

{% if 'zenoss_role' in grains and grains['zenoss_role'] == 'master' %}
zennoss_user:
  user.present:
    - home: /home/zenoss
    - fullname: Zenoss Server
    - name: zenoss

/home/zenoss/.ssh:
  file:
    - directory
    - user: zenoss
    - group: zenoss
    - mode: 700
    - makedirs: True

{%-     for key, value in salt['mine.get']('G@roles:zenoss_server and G@zenoss_role:collector', 'grains.items', 'compound').items() %}
finger_{{ value['id'] }}:
    ssh_known_hosts:
        - present
        - name: {{ value['id'] }}
        - user: zenoss
        - fingerprint: {{ salt['mine.get'](value['id'], 'grains.items').values()[0]['host_fingerprint'] }}
        - require:
          - file: /home/zenoss/.ssh
{%-     endfor %}


{% endif %}
