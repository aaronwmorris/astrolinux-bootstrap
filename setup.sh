#!/bin/bash

#set -x  # command tracing
set -o errexit
#set -o nounset

PATH=/bin:/usr/bin
export PATH



DISTRO_NAME=$(lsb_release -s -i)
DISTRO_RELEASE=$(lsb_release -s -r)
CPU_ARCH=$(uname -m)


echo "########################################################"
echo "### Welcome to the astrolinux-bootstrap setup script ###"
echo "########################################################"

echo
echo
echo "Distribution: $DISTRO_NAME"
echo "Release: $DISTRO_RELEASE"
echo
echo
echo "Setup proceeding in 10 seconds... (control-c to cancel)"
echo
sleep 10


# Run sudo to ask for initial password
sudo true

if [[ "$DISTRO_NAME" == "Raspbian" || "$DISTRO_NAME" == "Debian" || "$DISTRO_NAME" == "Ubuntu" ]]; then
    sudo apt-get update
    sudo apt-get -y install \
        build-essential \
        python3 \
        python3-pip \
        python3-apt \
        virtualenv \
        git

elif [[ "$DISTRO_NAME" == "CentOS" || "$DISTRO_NAME" == "Fedora" ]]; then
    sudo dnf -y install \
        '@Development tools' \
        python3 \
        python3-pip \
        python3-virtualenv \
        python3-dnf \
        git

else
    echo "Unknown distribution $DISTRO_NAME $DISTRO_RELEASE ($CPU_ARCH)"
    exit 1
fi


# find script directory for service setup
SCRIPT_DIR=$(dirname $0)
cd "$SCRIPT_DIR"
BOOTSTRAP_DIRECTORY=$PWD
cd $OLDPWD


echo "Python virtualenv setup"
[[ ! -d "${BOOTSTRAP_DIRECTORY}/virtualenv" ]] && mkdir -m 755 "${BOOTSTRAP_DIRECTORY}/virtualenv"
if [ ! -d "${BOOTSTRAP_DIRECTORY}/virtualenv/astrolinux-bootstrap" ]; then
    virtualenv -p python3 --system-site-packages ${BOOTSTRAP_DIRECTORY}/virtualenv/astrolinux-bootstrap
fi
source ${BOOTSTRAP_DIRECTORY}/virtualenv/astrolinux-bootstrap/bin/activate
pip3 install -r requirements.txt


