#
# adds all servers in the same environment
#
{%- for key, value in salt['mine.get']('environment_id:' + grains['environment_id'], 'grains.items', expr_form='grain').items() %}
{%-    if grains['id'] not in value['id'] %}
{%-        set old_ip = salt['hosts.get_ip'](value['id']) %}
{%-        if old_ip != "" %}
hosts-{{ value['id'] }}-removed:
  host.absent:
    - ip: {{ old_ip }}
    - name: {{ value['id'] }}
{%-        endif %}
hosts-{{ value['id'] }}-present:
  host.present:
    - ip: {{ salt['mine.get'](value['id'], 'network.ip_addrs').values()[0][1] }}
    - name: {{ value['id'] }}
{%-    endif %}
{%- endfor %}
