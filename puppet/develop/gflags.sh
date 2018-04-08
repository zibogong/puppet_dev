#! /bin/bash
set -e
NAME="gflags"
DOWNLOAD="https://github.com/gflags/gflags"
DOWNLOADS="/tmp/downloads/"

mkdir -p $DOWNLOADS

cd $DOWNLOADS
git clone $DOWNLOAD
cd $NAME
cmake .
make -j 24
make install

#rm -rf $DOWNLOADS

ldconfig

exit 0
