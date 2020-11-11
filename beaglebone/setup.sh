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
cd $HOME

# clean up home directory
rm -f $HOME/.gitconfig
rm -rf $HOME/bin

# apt
apt update
apt install vim curl
#apt-get install -y linux-headers-$(uname -r)

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

# symlink dot files
sudo -u debian mv -f .bashrc .bashrc.bak0
sudo -u debian ln -s -f nutbox/beaglebone/.bashrc
sudo -u debian ln -s -f nutbox/beaglebone/.gitconfig

# switch default python version
#update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1

# pipenv
#cd nutbox/beaglebone
#apt-get install -y pipenv
#export PIP_NO_CACHE_DIR="off"
#export PIPENV_TIMEOUT=9999
#sudo -E -u debian pipenv install
#sudo -E -u debian pipenv shell

# venv
#export PIP_NO_CACHE_DIR="off"
#apt-get install -y python3-venv
#cd nutbox/beaglebone
#python -m venv venv
#pip install -r requirements.txt

# jupyter labextensions
#sudo -E -u debian jupyter labextension install @jupyter-widgets/jupyterlab-manager

# report status
echo "Setup complete."

# scratch
# screen
# jupyter lab --no-browser --port=5678
