#!/bin/bash

# Setup script for the Nutbox Beaglebone. Run:
# sudo /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/tjcrone/nutbox-public/main/beaglebone/setup.sh)"

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

# apt
apt-get update
apt-get upgrade -y
apt-get dist-upgrade -y
apt-get install -y linux-headers-$(uname -r)
#apt-get install -y python3-venv

# switch default python version
#update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1

#pip
#update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1
#pip install --upgrade pip

# virtualenv
#pip install virtualenv

# report status
echo "Setup complete."


# scrarch
# screen
# jupyter lab --no-browser --port=5678
