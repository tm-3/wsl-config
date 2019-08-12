#!/bin/bash -i

if (( $EUID != 0 )); then

    sudo usr/local/bin/update.sh
    exit
fi
apt-get update
apt-get -y -q upgrade
apt-get -y -q dist-upgrade
apt-get clean
apt-get -y autoremove
apt purge -y $(dpkg -l | awk '/^rc/ { print $2 }')
