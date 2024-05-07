#!/bin/bash

function _start() {
    rpcbind -w
    mount -t nfsd nfsd /proc/fs/nfsd
    rpc.mountd
    exportfs -r
    rpc.nfsd -G 5
    rpc.statd --no-notify -F &
    wait ${!}
}

function _stop() {
    rpc.nfsd 0
    exportfs -au
    exportfs -f
    kill $(pidof rpc.statd) $(pidof rpc.mountd) $(pidof rpcbind)
    umount /proc/fs/nfsd

    exit 0
}

trap _stop SIGTERM

_start
