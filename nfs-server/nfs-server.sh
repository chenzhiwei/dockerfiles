#!/bin/bash

function _start_all() {
    mount -t nfsd nfsd /proc/fs/nfsd
    rpcbind -w
    rpc.mountd
    exportfs -r
    rpc.nfsd -G 5
    rpc.statd --no-notify -F &
    wait ${!}
}

function _start_v3() {
    mount -t nfsd nfsd /proc/fs/nfsd
    rpcbind -w
    rpc.mountd
    exportfs -r
    rpc.nfsd -N 4
    rpc.statd --no-notify -F &
    wait ${!}
}

function _start_v4() {
    mount -t nfsd nfsd /proc/fs/nfsd
    rpc.mountd
    exportfs -r
    rpc.nfsd -N 3
    wait $(pidof rpc.mountd)
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

_start_all
