FROM docker.io/library/ubuntu:latest

LABEL org.opencontainers.image.authors="zhiwei@youya.org"
LABEL org.opencontainers.image.documentation="https://github.com/chenzhiwei/dockerfiles"

RUN apt update \
    && apt install -y --no-install-recommends aria2 ca-certificates \
    && rm -rf /var/lib/apt/lists/*

COPY aria2.conf /etc/aria2/aria2.conf

CMD ["aria2c", "--conf-path=/etc/aria2/aria2.conf"]
