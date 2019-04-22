#!/bin/bash

BUILDROOT_VERSION=2019.02.1

set -e
CWD=$(dirname $(readlink -f $0))
BUILD_DIR=${CWD}/build
IMAGE_DIR=${CWD}/image

if [ ! -d $BUILD_DIR ]; then
    mkdir -p $BUILD_DIR
    TMPFILE=$(mktemp /tmp/my.XXXXX)
    wget https://buildroot.org/downloads/buildroot-${BUILDROOT_VERSION}.tar.bz2 -O $TMPFILE
    tar -jxf $TMPFILE --directory $BUILD_DIR --strip 1
    rm $TMPFILE
fi

cd $BUILD_DIR
make BR2_EXTERNAL=${CWD} ab_defconfig
make
cd $CWD

mkdir -p $IMAGE_DIR
cp ${BUILD_DIR}/output/images/sdcard.img ${IMAGE_DIR}
