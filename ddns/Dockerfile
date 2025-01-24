FROM docker.io/library/ubuntu:latest

LABEL org.opencontainers.image.authors="zhiwei@youya.org"
LABEL org.opencontainers.image.documentation="https://github.com/chenzhiwei/dockerfiles"

RUN apt update \
    && apt install -y --no-install-recommends ca-certificates curl jq tini \
    && rm -rf /var/lib/apt/lists/*

COPY cloudflare-ddns.sh /cloudflare-ddns.sh

CMD ["tini", "--", "/cloudflare-ddns.sh"]
