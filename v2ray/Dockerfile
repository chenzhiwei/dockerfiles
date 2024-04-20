FROM docker.io/library/alpine:latest AS builder

RUN apk add --no-cache ca-certificates curl
RUN curl -sLO https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip
RUN unzip -o -d / v2ray-linux-64.zip

FROM docker.io/library/alpine:latest

RUN apk add --no-cache ca-certificates curl

COPY --from=builder /v2ray /usr/bin/
COPY --from=builder /config.json /etc/v2ray/config.json

COPY v2ray.sh /v2ray.sh

CMD ["/v2ray.sh"]
