#!/bin/bash

if ! [[ -f /etc/libvirt/qemu/networks/default.xml ]]; then
    cp /default-network.xml /etc/libvirt/qemu/networks/default.xml
    cd /etc/libvirt/qemu/networks/autostart && ln -s /etc/libvirt/qemu/networks/default.xml default.xml
fi

exit 0
