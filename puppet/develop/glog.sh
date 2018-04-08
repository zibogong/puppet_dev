#! /bin/bash
set -e
NAME="glog"
DOWNLOAD="https://github.com/google/glog"
DOWNLOADS="/tmp/downloads/"

#rm -rf $DOWNLOADS
#mkdir -p $DOWNLOADS

cd $DOWNLOADS
git clone $DOWNLOAD
cd $NAME
./autogen.sh
./configure
make -j 24
make install

#rm -rf $DOWNLOADS

ldconfig

exit 0
