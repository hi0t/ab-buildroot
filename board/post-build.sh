#!/bin/sh

set -e

mkdir -p $TARGET_DIR/etc/sudoers.d
echo "ab ALL = ALL" > $TARGET_DIR/etc/sudoers.d/ab
chmod 0440 $TARGET_DIR/etc/sudoers.d/ab

(
    echo ""
    echo "# Raspberry Pi devices"
    echo "gpiomem	root:gpio 660"
) >> $TARGET_DIR/etc/mdev.conf

(
    echo ""
    echo "auto wlan0"
    echo "iface wlan0 inet dhcp"
    echo "  pre-up wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant.conf"
    echo "  post-down killall -q wpa_supplicant"
    echo "  wait-delay 15"
    echo "  hostname \$(hostname)"
) >> $TARGET_DIR/etc/network/interfaces
