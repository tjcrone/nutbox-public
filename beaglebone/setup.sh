#!/bin/bash

# Setup script for the Nutbox Beaglebone.
# This script works with: bone-eMMC-flasher-debian-10.5-console-armhf-2020-08-25-1gb.img

set -e

# locations
HOME="/home/debian"
NUTBOX="$HOME/nutbox"

# move to user home
echo "Setting up Beaglebone ..."
cd $HOME

# run root script
wget https://raw.githubusercontent.com/tjcrone/nutbox-public/main/beaglebone/setup.sh
sudo /bin/bash setup_root.sh

# run user script
wget https://raw.githubusercontent.com/tjcrone/nutbox-public/main/beaglebone/setup_user.sh
/bin/bash setup_user.sh
