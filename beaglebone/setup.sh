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

# clean up home directory
rm -f $HOME/.gitconfig
rm -rf $HOME/bin

# apt
apt update
apt install -y vim curl git python3 python3-venv linux-headers-$(uname -r)

# alternatives
update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1

# install deploy key
rm -rf ".ssh"
curl -L -o "deploy.tar.gpg" "https://github.com/tjcrone/nutbox-public/blob/main/beaglebone/deploy.tar.gpg?raw=true"

decrypt_file () {
    gpg --no-symkey-cache -d "deploy.tar.gpg" > "deploy.tar"
}

while ! decrypt_file; do
    echo "Incorrect password. Try again."
done

tar -xvf "deploy.tar"
rm "deploy.tar"
rm "deploy.tar.gpg"

# clone the nutbox private repo
rm -rf nutbox
sudo -u debian git clone "git@github.com:tjcrone/nutbox.git"

# symlink dotfiles
sudo -u debian mv -f .bashrc .bashrc.bak0
sudo -u debian ln -s -f nutbox/beaglebone/.bashrc
sudo -u debian ln -s -f nutbox/beaglebone/.gitconfig

# venv
export PIP_NO_CACHE_DIR="off"
python -m venv venv
source venv/bin/activate
pip install -r nutbox/beaglebone/requirements.txt

# remove setup file
rm "setup.sh"

# report status
echo "Beaglebone setup complete."

# instructions
echo "Run Jupyterlab with:"
echo "jupyter lab --no-browser --port=5678"

# scratch
# screen
