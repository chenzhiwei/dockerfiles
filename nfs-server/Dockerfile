FROM docker.io/library/ubuntu:22.04

RUN apt update \
    && apt -y install nfs-server --no-install-recommends \
    && rm -rf /var/lib/apt/lists/*

COPY exports /etc/exports
COPY nfs-server.sh /nfs-server.sh

VOLUME /var/nfs

CMD ["/nfs-server.sh"]
