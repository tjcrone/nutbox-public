#!/bin/bash

# Setup script for the Nutbox Beaglebone. Run:
# sudo /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/tjcrone/nutbox-public/main/beaglebone/setup.sh)"

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
#rm -f $HOME/.gitconfig
#rm -rf $HOME/bin


# report status
echo "Setup complete."
