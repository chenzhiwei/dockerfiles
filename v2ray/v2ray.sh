#!/bin/sh

## start process
function _start() {
    v2ray -config /etc/v2ray/config.json &
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
    current=$(cat /tmp/v2ray.current)
    latest=$(curl -Is https://github.com/v2ray/v2ray-core/releases/latest/download/v2ray-linux-64.zip | awk '/^Location/ {print $2;exit}')
    if [[ "$current" != "$latest" ]]; then
        mkdir -p v2ray
        wget -P v2ray https://github.com/v2ray/v2ray-core/releases/latest/download/v2ray-linux-64.zip
        unzip -o -d v2ray v2ray/v2ray-linux-64.zip
        \cp v2ray/v2ray v2ray/v2ctl /usr/bin/
        rm -rf v2ray
        echo $latest > /tmp/v2ray.current
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
