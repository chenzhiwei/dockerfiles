#!/bin/sh

V2RAY_SERVER_MODE=${V2RAY_SERVER_MODE:-true}

VMESS_ADDR=${VMESS_ADDR:-127.0.0.1}
VMESS_PORT=${VMESS_PORT:-443}
VMESS_UUID=${VMESS_UUID:-00000000-0000-0000-0000-000000000000}
VMESS_SERVER_NAME=${VMESS_SERVER_NAME:-localhost}
VMESS_WS_PATH=${VMESS_WS_PATH:-/}

V2RAY_CONFIG_FILE=${V2RAY_CONFIG_FILE:-/etc/v2ray/v2ray.json}

if [ "$V2RAY_SERVER_MODE" != "true" ]; then
    sed -e "s/vmess.addr/$VMESS_ADDR/g" \
        -e "s/vmess.port/$VMESS_PORT/g" \
        -e "s/vmess.uuid/$VMESS_UUID/g" \
        -e "s/vmess.serverName/$VMESS_SERVER_NAME/g" \
        -e "s@vmess.ws.path@$VMESS_WS_PATH@g" \
        -i $V2RAY_CONFIG_FILE
fi

exec v2ray run -c $V2RAY_CONFIG_FILE
