#!/bin/bash

function start() {
    rpcbind -w
    mount -t nfsd nfsd /proc/fs/nfsd
    rpc.mountd
    exportfs -r
    rpc.nfsd -G 10
    rpc.statd --no-notify

    showmount -e
    if [[ $? -eq 0 ]]; then
        echo "NFS Server started"
    else
        exit 1
    fi
}

function stop() {
    rpc.nfsd 0
    exportfs -au
    exportfs -f
    kill $(pidof rpc.mountd)
    umount /proc/fs/nfsd

    exit 0
}

trap stop TERM

start

while true; do
    sleep 99999d
done
