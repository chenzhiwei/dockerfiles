FROM docker.io/library/alpine:latest

RUN apk add --no-cache bind-tools tini

COPY cloudflare-ddns.sh /cloudflare-ddns.sh

CMD ["tini", "--", "/cloudflare-ddns.sh"]
