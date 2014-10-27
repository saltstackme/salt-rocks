#
# fixes graphs on remote collectors
# has to run on both master and all remote collectors
#
{%- if 'zenoss_installed' in grains or grains['zenoss_installed'] == true %}

{%- if salt['cmd.run']('ls /opt/zenoss/etc/DAEMONS_TXT_ONLY|wc -l') == '1' and salt['cmd.run']('ls /opt/zenoss/etc/daemons.txt|wc -l') == '1' %}
{%-     if salt['cmd.run']('grep zenrender /opt/zenoss/etc/daemons.txt|wc -l') == '1' %}
{%-         set zenrender_status = "zenrender has already been configured" %}
{%-     else %}

add_zenrender:
  cmd:
    - run
    - name : echo "zenrender" >> /opt/zenoss/etc/daemons.txt

zenoss:
  service:
    - running
    - enable: True
    - watch:
      - cmd: add_zenrender    

{%-         set zenrender_status = "zenrender is added to daemons configuration and service is restared" %}
{%-     endif %}
{%- else %}
{%-     set zenrender_status = "Please add this collector instance to zenoss master with remote collector zenpack" %}
{%- endif %}

/tmp/zenrender_status:
  file:
    - managed
    - source: salt://zenoss/files/status.jinja
    - template: jinja
    - defaults:
        status_text: {{ zenrender_status }}

[%- endif %}
