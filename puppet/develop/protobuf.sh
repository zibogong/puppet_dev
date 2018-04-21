#! /bin/bash
set -e
NAME="protobuf-3.5.1"
ARCHIVE="$NAME.tar.gz"
DOWNLOAD="https://github.com/google/protobuf/releases/download/v3.5.1/protobuf-all-3.5.1.tar.gz"
DOWNLOADS="/tmp/downloads/"

mkdir -p $DOWNLOADS

cd $DOWNLOADS
wget -q "$DOWNLOAD" -O $ARCHIVE
tar -xzf $ARCHIVE
cd $NAME

./configure
make -j 24
make check
make install

#rm -rf $DOWNLOADS

ldconfig

exit 0
