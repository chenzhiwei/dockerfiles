#!/bin/sh

AUTO_CONFIGURE=${AUTO_CONFIGURE:-true}

function sigterm_handler() {
    local pids=$(ps -ef | awk '/ haproxy / {print $1}')
    kill -SIGTERM $pids
    wait $pids
    exit 143
}

function create_config() {
    for info in ${INFO//|/ }; do
        port=${info%%@*}
        backends=${info#*@}

        echo "
listen server-$port
    bind :$port
    mode tcp
    option tcplog
    balance source
" >> /etc/haproxy.cfg


        index=0
        for backend in ${backends//,/ }; do
            index=$(( index+1 ))
            echo "    server server$index $backend" >> /etc/haproxy.cfg
        done
        echo >> /etc/haproxy.cfg
    done
}

if [[ "$INFO" == "" ]]; then
    echo ""
    echo "Please set INFO environment variable, such as:"
    echo ""
    echo "docker run -d --net=host --name=haproxy -e INFO='7443@1.1.1.1:6443,2.2.2.2:6443|8443@3.3.3.3:8043,4.4.4.4:8043' siji/haproxy:1.9.7"
    echo ""
    exit 1
fi

cp /usr/local/etc/haproxy/haproxy.cfg /etc/haproxy.cfg
mkdir -p /var/lib/haproxy

if [[ "$AUTO_CONFIGURE" == "true" ]]; then
    create_config
fi

trap 'kill ${!}; sigterm_handler' SIGTERM

haproxy -W -db -f /etc/haproxy.cfg & wait ${!}
