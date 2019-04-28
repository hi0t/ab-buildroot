#!/bin/sh

set -e

mkdir -p $TARGET_DIR/etc/sudoers.d
echo "ab ALL = ALL" > $TARGET_DIR/etc/sudoers.d/ab
chmod 0440 $TARGET_DIR/etc/sudoers.d/ab

echo "" >> $TARGET_DIR/etc/mdev.conf
echo "# Raspberry Pi devices" >> $TARGET_DIR/etc/mdev.conf
echo "gpiomem	root:gpio 660" >> $TARGET_DIR/etc/mdev.conf
