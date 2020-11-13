#!/bin/bash

# Setup script for the Nutbox Beaglebone. User-space components
# This script works with: bone-eMMC-flasher-debian-10.5-console-armhf-2020-08-25-1gb.img

set -e

# locations
HOME="/home/debian"
NUTBOX="$HOME/nutbox"

# move to user home
echo "Setting up Beaglebone ..."
cd $HOME

# install deploy key
rm -rf ".ssh"
curl -L -o "deploy.tar.gpg" "https://github.com/tjcrone/nutbox-public/blob/main/deploy.tar.gpg?raw=true"

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
git clone "git@github.com:tjcrone/nutbox.git"

# symlink dotfiles
mv -f .bashrc .bashrc.bak0
ln -s -f nutbox/beaglebone/.bashrc
ln -s -f nutbox/beaglebone/.gitconfig

# venv
export PIP_NO_CACHE_DIR="off"
python -m venv venv
source venv/bin/activate
pip install -r nutbox/beaglebone/requirements.txt

# jupyterlab script
/bin/bash jlab_screen.sh
