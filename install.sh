#!/bin/sh -xe
# directory
dir='/tmp/ddclient'
mkdir ${dir} && cd ${dir}
# fetch ddclient
wget $(wget -q -O - https://api.github.com/repos/ddclient/ddclient/releases/latest  |  jq -r '.assets[] | select(.name | contains ("ddclient-")) | .browser_download_url')
tar -xf *.tar.gz && cd *
# install package
./configure --prefix=${dir}/user --sysconfdir=${dir}/etc --localstatedir=${dir}/var
make && make VERBOSE=1 check && make install
# cleanup
cd ${dir} && rm *.tar.gz
