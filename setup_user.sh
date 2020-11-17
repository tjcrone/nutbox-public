#!/bin/bash

# error checking
set -o errexit
set -o nounset
set -o pipefail

# locations
HOME="/home/debian"
NUTBOX="$HOME/nutbox"

# move to user home
cd $HOME

# install deploy key
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
git clone "git@github.com:tjcrone/nutbox.git"

# symlink dotfiles
ln -s -f nutbox/beaglebone/.bashrc
ln -s -f nutbox/beaglebone/.bash_logout
ln -s -f nutbox/beaglebone/.profile
ln -s -f nutbox/beaglebone/.gitconfig

# venv
export PIP_NO_CACHE_DIR="off"
python -m venv venv
source venv/bin/activate
pip install --pre jupyterlab
pip install ipywidgets
pip install --pre jupyterlab_widgets
pip install Adafruit-BBIO matplotlib numpy pandas xarray

# copy Jlab configuration
mkdir "${HOME}/.jupyter"
cp "/home/debian/nutbox/beaglebone/jupyter_lab_config.py" "${HOME}/.jupyter"

# favicon fixes
SOURCE_DIR="${HOME}/venv/lib/python3.7/site-packages/notebook/static/base/images/"
ICON_DIR="${HOME}/venv/lib/python3.7/site-packages/jupyter_server/static/favicons"
mkdir -p $ICON_DIR
find "${SOURCE_DIR}" -type f -name "*.ico" | xargs -I {} cp {} $ICON_DIR
