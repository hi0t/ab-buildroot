#!/bin/sh

set -e

test -d $TARGET_DIR/etc/sudoers.d || mkdir $TARGET_DIR/etc/sudoers.d
test -f $TARGET_DIR/etc/sudoers.d/ab || \
    echo "ab ALL = ALL" >$TARGET_DIR/etc/sudoers.d/ab; \
    chmod 0440 $TARGET_DIR/etc/sudoers.d/ab
