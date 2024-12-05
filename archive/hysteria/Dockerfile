FROM docker.io/library/alpine:latest AS builder

RUN apk add --no-cache ca-certificates curl
RUN curl -sLO https://github.com/apernet/hysteria/releases/latest/download/hysteria-linux-amd64
RUN chmod +x hysteria-linux-amd64

FROM docker.io/library/alpine:latest

LABEL org.opencontainers.image.authors="zhiwei@youya.org"
LABEL org.opencontainers.image.documentation="https://github.com/chenzhiwei/dockerfiles"

RUN apk add --no-cache ca-certificates curl

COPY --from=builder /hysteria-linux-amd64 /usr/bin/hysteria

CMD ["hysteria", "server", "-c", "/etc/hysteria/config.yaml"]
