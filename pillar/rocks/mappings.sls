rocks:
    package:
    {%- if grains['os_family'] == 'RedHat' %}

        python-devel: python-devel
        libevent: libevent
        libevent-devel: libevent-devel
        ntp: ntpd
        ntp-conf: /etc/ntp.conf
        snmp-pkg: net-snmp
        snmp-service: snmpd
        snmp-conf: /etc/snmp/snmpd.conf
        cron-pkg: crontabs
        cron-service: crond
        ssh-service: sshd

    {%- elif grains['os_family'] == 'Debian' %}

        python-devel: python-dev
        libevent: libevent-dev
        libevent-devel: libevent-dev
        ntp: ntp
        ntp-conf: /etc/ntp.conf
        snmp-pkg: snmpd
        snmp-service: snmpd
        snmp-conf: /etc/snmp/snmp.conf
        cron-pkg: cron
        cron-service: cron
        ssh-service: ssh

    {%- endif %}