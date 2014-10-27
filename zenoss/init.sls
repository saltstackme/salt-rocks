{%- if grains.get("kernel", "Unknown") == "Linux" %}
{%- if 'roles' in grains and 'zenoss_server' in grains['roles'] %}

include:
  - zenoss.hosts
  - zenoss.fingerprints
  - zenoss.install 
#  - zenoss.render

{%- endif %}
{%- endif %}
