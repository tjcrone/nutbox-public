#!/bin/bash

# Setup script for the Nutbox Beaglebone.
# This script works with: bone-eMMC-flasher-debian-10.5-console-armhf-2020-08-25-1gb.img

set -e

# locations
HOME="/home/debian"
NUTBOX="$HOME/nutbox"

# check for root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root."
   exit 1
fi

# move to user home
echo "Setting up Beaglebone ..."
cd $HOME

# run root script
wget https://raw.githubusercontent.com/tjcrone/nutbox-public/main/beaglebone/setup_root.sh
/bin/bash setup_root.sh

# run user script
wget https://raw.githubusercontent.com/tjcrone/nutbox-public/main/beaglebone/setup_user.sh
sudo -u debian /bin/bash setup_user.sh
