#!/bin/bash

# Setup script for the Nutbox Beaglebone.
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

# remove setup cruft
rm "setup_root.sh"
rm "setup_user.sh"
rm ".wget-hsts"
rm -rf ".gnupg"

# report status
echo "Beaglebone setup complete."
echo "Starting Jupyterlab server ..."

# start jlab server
sudo -u debian wget https://raw.githubusercontent.com/tjcrone/nutbox-public/main/jlab_screen.sh
chmod 744 jlab_screen.sh
sudo -u debian screen -dm /bin/bash -c "/home/debian/jlab_screen.sh; exec sh"
#rm "jlab_screen.sh"
#rm ".wget-hsts"
