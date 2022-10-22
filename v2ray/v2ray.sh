#!/bin/sh

export CONFIG=${CONFIG:-/etc/v2ray/config.json}

## start process
function _start() {
    v2ray run -config $CONFIG &
    sleep 3
}

## stop process
function _stop() {
    pkill -9 v2ray
    sleep 3
}

## check process
function _check() {
    pidof v2ray >/dev/null
}

## renew process
function _renew() {
    curl -sLO https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip
    mkdir -p v2ray
    unzip -o -d v2ray v2ray-linux-64.zip
    new=$(du v2ray/v2ray | awk '{print $1}')
    old=$(du /usr/bin/v2ray | awk '{print $1}')
    if [[ "$new" != "$old" ]]; then
        \cp v2ray/v2ray /usr/bin/
        rm -rf v2ray v2ray-linux-64.zip
    fi
}

# start v2ray
_start

# periodically renew v2ray
while true; do
    _check
    if [[ $? -ne 0 ]]; then
        sleep 60s
        _start
        continue
    fi

    sleep 5m

    current_date=$(date +%s)
    current_time=$((($current_date % 86400 + 28800) % 86400))
    # the current time is between 03:30:00 and 03:40:00
    if [[ $current_time -gt 12600 ]] && [[ $current_time -lt 13200 ]]; then
        echo "renew at $(date)"
        _stop
        _renew
        sleep 10m
    fi
done
