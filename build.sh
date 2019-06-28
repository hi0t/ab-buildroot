#!/bin/bash

BUILDROOT_VERSION=2019.02.3

set -e
CWD=$(dirname $(readlink -f $0))
BUILD_DIR=${CWD}/build

if [ ! -d $BUILD_DIR ]; then
    mkdir -p $BUILD_DIR
    TMPFILE=$(mktemp /tmp/my.XXXXX)
    wget https://buildroot.org/downloads/buildroot-${BUILDROOT_VERSION}.tar.bz2 -O $TMPFILE
    tar -jxf $TMPFILE --directory $BUILD_DIR --strip 1
    rm $TMPFILE
fi

export BR2_CCACHE=y
export BR2_CCACHE_DIR=/tmp/buildroot-ccache
export BR2_CCACHE_INITIAL_SETUP="--max-size=1G"
cd $BUILD_DIR
make BR2_EXTERNAL=${CWD} ab_defconfig
make
cd $CWD
