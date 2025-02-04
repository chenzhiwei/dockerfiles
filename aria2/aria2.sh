#!/usr/bin/env bash

ARIA2_DIR=${ARIA2_DIR:-/downloads}
ARIA2_DISK_CACHE=${ARIA2_DISK_CACHE:-256M}
ARIA2_RPC_SECRET=${ARIA2_RPC_SECRET:-aria2c}

mkdir -p /config
sed -e "s@dir=.*@dir=${ARIA2_DIR}@g" \
    -e "s@disk-cache=.*@disk-cache=${ARIA2_DISK_CACHE}@g" \
    -e "s@rpc-secret=.*@rpc-secret=${ARIA2_RPC_SECRET}@g" \
    /aria2.conf > /config/aria2.conf

touch /config/aria2.session

exec aria2c --conf-path=/config/aria2.conf
