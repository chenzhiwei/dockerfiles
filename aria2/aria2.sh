#!/usr/bin/env bash

ARIA2_DIR=${ARIA2_DIR:-/downloads}
ARIA2_DISK_CACHE=${ARIA2_DISK_CACHE:-128M}
ARIA2_RPC_SECRET=${ARIA2_RPC_SECRET:-aria2c}
ARIA2_SPLIT=${ARIA2_SPLIT:-5}
ARIA2_MAX_CONNECTION_PER_SERVER=${ARIA2_MAX_CONNECTION_PER_SERVER:-1}

mkdir -p /config
sed -e "s@dir=.*@dir=${ARIA2_DIR}@g" \
    -e "s@disk-cache=.*@disk-cache=${ARIA2_DISK_CACHE}@g" \
    -e "s@rpc-secret=.*@rpc-secret=${ARIA2_RPC_SECRET}@g" \
    -e "s@split=.*@split=${ARIA2_SPLIT}@g" \
    -e "s@max-connection-per-server=.*@max-connection-per-server=${ARIA2_MAX_CONNECTION_PER_SERVER}@g" \
    /aria2.conf > /config/aria2.conf

touch /config/aria2.session

exec aria2c --conf-path=/config/aria2.conf
