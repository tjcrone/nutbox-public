#!/bin/bash

# error checking
set -o errexit
set -o nounset
set -o pipefail

# check for root
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root."
  exit 1
fi

# apt
apt update
apt install -y \
  build-essential \
  curl \
  git \
  libatlas-base-dev \
  libjpeg62-turbo \
  libopenjp2-7 \
  libtiff5 \
  libxcb1 \
  linux-headers-$(uname -r) \
  locales \
  network-manager \
  python3 \
  python3-venv \
  screen \
  vim

# locales
echo en_US.UTF UTF-8 >> /etc/locale.gen
/usr/sbin/locale-gen

# update-alternatives
update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1

# connect to wifi
echo
echo "Setting up wifi ..."
read -p "Name of wifi network: " wifi_name
nmcli -a d wifi connect $wifi_name
