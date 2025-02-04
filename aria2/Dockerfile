FROM docker.io/library/ubuntu:latest

LABEL org.opencontainers.image.authors="zhiwei@youya.org"
LABEL org.opencontainers.image.documentation="https://github.com/chenzhiwei/dockerfiles"

RUN apt update \
    && apt install -y --no-install-recommends aria2 ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY aria2.sh aria2.conf /
WORKDIR /config

CMD ["/aria2.sh"]
