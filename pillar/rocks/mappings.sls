rmap:
  package:
    {%- if grains['os_family'] == 'RedHat' %}

        python-devel: python-devel
        libevent: libevent
        libevent-devel: libevent-devel
        ntp: ntpd
        ntp: /etc/ntp.conf
        snmp: net-snmp
        cron: crontabs

    {%- elif grains['os_family'] == 'Debian' %}

        python-devel: python-dev
        libevent: libevent-dev
        libevent-devel: libevent-dev
        ntp: ntp
        snmp: snmpd
        cron: cron

    {%- endif %}

  service:
    {%- if grains['os_family'] == 'RedHat' %}

        ntp: ntpd
        snmp: snmpd
        cron: crond
        ssh: sshd

    {%- elif grains['os_family'] == 'Debian' %}

        ntp: ntp
        snmp: snmpd
        cron: cron
        ssh: ssh

    {%- endif %}

  config:
    {%- if grains['os_family'] == 'RedHat' %}

        ntp: /etc/ntp.conf
        snmp: /etc/snmp/snmpd.conf

    {%- elif grains['os_family'] == 'Debian' %}

        ntp-conf: /etc/ntp.conf
        snmp-conf: /etc/snmp/snmp.conf

    {%- endif %}
