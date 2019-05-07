# docker

Docker is a Linux Container.

## Docker images

This repository contains some Dockerfiles that I used.

## Build an Ubuntu sshd Docker image

```
# docker build --build-arg ROOT_PASSWORD=password -t ubuntu/sshd https://github.com/chenzhiwei/dockerfile.git#master:ubuntu
```

## Build a CentOS sshd Docker image

```
# docker build --build-arg ROOT_PASSWORD=password -t centos/sshd https://github.com/chenzhiwei/dockerfile.git#master:centos
```


## Run a Docker container

```
# docker run -d -p 2222:22 --name="sshd" --hostname=ubuntu ubuntu/sshd
# ssh -p 2222 root@127.0.0.1
```

## Running GUI apps

Reference: <http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/>

```
FROM ubuntu:14.04

RUN apt-get update && apt-get install -y firefox

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

USER developer
ENV HOME /home/developer
CMD /usr/bin/firefox
```

```
# docker run -ti --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix firefox
```

## Build Multiarch image

```
manifest-tool push from-args --platforms linux/amd64,linux/ppc64le,linux/s390x --template siji/haproxy-ARCH:1.9.7 --target siji/haproxy:latest --ignore-missing
```

## Issues

The warning when run `locale` command like this `locale: Cannot set LC_CTYPE to default locale: No such file or directory` means you did not generate en_US.UTF-8.

This locale issue can be solved by run `localedef -v -c -i en_US -f UTF-8 en_US.UTF-8` on CentOS, and `locale-gen en_US.UTF-8` on Ubuntu.

If you can't find `localedef` command on CentOS, you need to reinstall `glibc-common` package, `locales` package on Ubuntu.

## In the End

Docker document: <https://docs.docker.com>
