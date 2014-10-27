#
# adds all zenoss servers in all environments for the same project
#
{%- if 'roles' in grains and 'zenoss_server' in grains['roles'] %}
{%-   for key, value in salt['mine.get']('roles:zenoss_server', 'grains.items', expr_form='grain').items() %}
{%-     if value['project'] == pillar['project']  %}
host_{{ value['id'] }}:
  host:
    - present
    - name: {{ value['id'] }}
    - ip: {{ salt['mine.get'](value['id'], 'network.ip_addrs').values()[0][1] }}

node_{{ value['nodename'] }}:
  host:
    - present
    - name: {{ value['nodename'] }}
    - ip: {{ salt['mine.get'](value['id'], 'network.ip_addrs').values()[0][1] }}

{%-     endif %}
{%-   endfor %}
{%- endif %}
