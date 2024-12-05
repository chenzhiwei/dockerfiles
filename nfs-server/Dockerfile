FROM docker.io/library/debian:stable-slim

LABEL org.opencontainers.image.authors="zhiwei@youya.org"
LABEL org.opencontainers.image.documentation="https://github.com/chenzhiwei/dockerfiles"

RUN apt update \
    && apt -y install nfs-kernel-server --no-install-recommends \
    && mkdir -p /var/nfs \
    && rm -rf /usr/lib/python* /usr/bin/py* /usr/share/python* \
    && rm -rf /var/lib/apt/lists/*

COPY exports /etc/exports
COPY nfs-server.sh /nfs-server.sh

CMD ["/nfs-server.sh"]
