#!/bin/bash

# Main setup script for the Nutbox Beaglebone.
# This script works with: bone-eMMC-flasher-debian-10.5-console-armhf-2020-08-25-1gb.img

set -o errexit
set -o nounset
set -o pipefail

# report status
echo "Setting up Beaglebone ..."

# locations
HOME="/home/debian"
NUTBOX="$HOME/nutbox"

# check for root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root."
   exit 1
fi

# change user password
passwd debian

# clean up home directory
rm -rf $HOME
mkdir $HOME
chown debian:debian $HOME
cd $HOME

# run root script
wget https://raw.githubusercontent.com/tjcrone/nutbox-public/main/setup_root.sh
/bin/bash setup_root.sh

# run user script
wget https://raw.githubusercontent.com/tjcrone/nutbox-public/main/setup_user.sh
sudo -u debian /bin/bash setup_user.sh

# copy Jlab boot script
cp "/home/debian/nutbox/beaglebone/rc.local" /etc/

# remove setup cruft
rm "setup_root.sh"
rm "setup_user.sh"
rm ".wget-hsts"
rm -rf ".gnupg"

# report status
echo
echo "Beaglebone setup complete."
