FROM docker.io/library/alpine:latest

LABEL org.opencontainers.image.authors="zhiwei@youya.org"
LABEL org.opencontainers.image.documentation="https://github.com/chenzhiwei/dockerfiles"

RUN apk add --no-cache curl tini

COPY cloudflare-ddns.sh /cloudflare-ddns.sh

CMD ["tini", "--", "/cloudflare-ddns.sh"]
