#!/bin/bash -e

PATH=$(pwd)/ci/build/bin:$PATH

if [ ! -d ci ]; then
    echo "you must run this in the root fping directory" >&2
    exit 1
fi

autoreconf -i
./configure --enable-ipv4 --enable-ipv6 --prefix=/opt/fping
make CFLAGS="-g -fprofile-arcs -ftest-coverage"
sudo setcap cap_net_raw+ep src/fping
sudo setcap cap_net_raw+ep src/fping6
