rmap:
  package:
    {%- if grains['os_family'] == 'RedHat' %}

        python-devel: python-devel
        libevent: libevent
        libevent-devel: libevent-devel
        cron: crontabs

    {%- elif grains['os_family'] == 'Debian' %}

        python-devel: python-dev
        libevent: libevent-dev
        libevent-devel: libevent-dev
        cron: cron

    {%- endif %}

  service:
    {%- if grains['os_family'] == 'RedHat' %}

        cron: crond
        ssh: sshd

    {%- elif grains['os_family'] == 'Debian' %}

        cron: cron
        ssh: ssh

    {%- endif %}

  config:
    {%- if grains['os_family'] == 'RedHat' %}

        emacs: /root/.emacs

    {%- elif grains['os_family'] == 'Debian' %}

        emacs: /root/.emacs

    {%- endif %}
