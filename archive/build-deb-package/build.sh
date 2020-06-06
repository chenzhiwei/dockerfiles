#!/bin/bash

BASE=$(cd $(dirname $0) && pwd)
DATETIME=$(date +%Y%m%d%H%M%S)
PACKAGE_DIR=$BASE/$DATETIME

function pre_check() {
    local flag=0

    if [ $UID -ne 0 ]; then
        echo Please run this script using root
        flag=1
    fi

    if ! docker info &>/dev/null; then
        echo Please install/start Docker service
        flag=1
    fi

    if [ $flag -ne 0 ]; then
        exit 1
    fi
}

function build_image() {
    docker build -t mesos:$DATETIME $BASE
    if [ $? -ne 0 ]; then
        echo Build Mesos image failed
        exit 1
    fi
}

function extract_package() {
    mkdir -p $PACKAGE_DIR
    docker run --rm -v $PACKAGE_DIR:/data:rw mesos:$DATETIME cp /usr/local/mesos.tar.gz /data
    if [ $? -ne 0 ]; then
        echo Extract package failed
        exit 1
    fi
    echo Package is under $PACKAGE_DIR
    echo Please extract to /usr/local/mesos
    echo tar xf $PACKAGE_DIR/mesos.tar.gz -C /usr/local
}

function remove_image() {
    docker rmi mesos:$DATETIME
}

pre_check
build_image
extract_package
remove_image
