FROM alpine AS builder

RUN apk add --no-cache jq curl

RUN VERSION=$(curl -s https://api.github.com/repos/v2fly/v2ray-core/releases/latest | jq -r .name) \
    && curl -sLO https://github.com/v2fly/v2ray-core/releases/download/$VERSION/v2ray-linux-64.zip \
    && unzip -o -d / v2ray-linux-64.zip

FROM alpine

RUN apk add --no-cache ca-certificates curl jq

COPY --from=builder /v2ray /v2ctl /usr/bin/
COPY --from=builder /config.json /etc/v2ray/config.json

COPY v2ray.sh /usr/local/bin/v2ray.sh

CMD ["v2ray.sh"]
