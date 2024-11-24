FROM docker.io/library/debian:stable-slim

LABEL org.opencontainers.image.authors="zhiwei@youya.org"
LABEL org.opencontainers.image.documentation="https://github.com/chenzhiwei/dockerfiles"

RUN apt update \
    && apt install -y --no-install-recommends aria2 ca-certificates \
    && rm -rf /var/lib/apt/lists/*

CMD ["aria2c", "--enable-rpc", "--rpc-allow-origin-all", "--rpc-listen-all", "--dir=/downloads"]
