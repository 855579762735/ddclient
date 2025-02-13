#!/bin/sh -xe

# variables
tmpdir='/tmp/install'

# temporary directory
mkdir ${tmpdir}
cd ${tmpdir}

# fetch ddclient
wget $(wget -q -O - https://api.github.com/repos/ddclient/ddclient/releases/latest  |  jq -r '.assets[] | select(.name | contains (".tar.gz")) | .browser_download_url')
tar -xf *.tar.gz
cd *ddclient*

# Install package
mkdir /etc/ddclient
mkdir /var/cache/ddclient
cp ddclient /usr/bin/ddclient
cp sample-etc_ddclient.conf /etc/ddclient/ddclient.conf

# Clean Up
cd /
rm -rf ${tmpdir}

#wget https://github.com/ddclient/ddclient/releases/latest/download/ddclient-${version}.tar.gz
#wget https://github.com/wimpunk/ddclient/archive/v${version}.tar.gz
#version='4.0.0'
