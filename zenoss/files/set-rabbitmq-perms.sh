#!/usr/bin/env bash

set -e

VHOSTS="/zenoss"
USER="zenoss"
PASS="grep amqppassword \$ZENHOME/etc/global.conf | awk '{print \$2}'"

if [ $(id -u) -eq 0 ]
then
    RABBITMQCTL=$(which rabbitmqctl)
    $RABBITMQCTL stop_app
    $RABBITMQCTL reset
    $RABBITMQCTL start_app
    $RABBITMQCTL add_user "$USER" "$(su -l zenoss -c "$PASS")"

    for vhost in $VHOSTS; do
        $RABBITMQCTL add_vhost "$vhost"
        $RABBITMQCTL set_permissions -p "$vhost" "$USER" '.*' '.*' '.*'
    done
    exit 0
else
    echo "Error: Run this script as the root user." >&2
    exit 1
fi