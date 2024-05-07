#!/bin/bash

NFSVER=${NFSVER:-all}

function _start_all() {
    mount -t nfsd nfsd /proc/fs/nfsd
    rpcbind -w
    rpc.mountd
    exportfs -r
    rpc.nfsd
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
    rpc.mountd -F 2>/dev/null &
    pid=${!}
    exportfs -r
    rpc.nfsd -N 3
    wait $pid
}

function _stop() {
    rpc.nfsd 0
    exportfs -au
    exportfs -f
    kill $(pidof rpc.statd) $(pidof rpc.mountd) $(pidof rpcbind)
    umount /proc/fs/nfsd
}

trap _stop SIGTERM

if [[ $NFSVER == "3" ]]; then
    _start_v3
elif [[ $NFSVER == "4" ]]; then
    _start_v4
else
    _start_all
fi
