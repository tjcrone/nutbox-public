#!/bin/bash

# Setup script for the Nutbox Beaglebone.
# This script works with: bone-eMMC-flasher-debian-10.5-console-armhf-2020-08-25-1gb.img

set -e

# check for root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root."
   exit 1
fi

# apt
apt update
apt install -y vim curl git python3 python3-venv screen linux-headers-$(uname -r)

# update-alternatives
update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1
