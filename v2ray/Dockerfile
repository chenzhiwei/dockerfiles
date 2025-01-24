FROM docker.io/library/ubuntu:latest AS builder

RUN apt update && apt install -y ca-certificates curl unzip
RUN arch=$(uname -m | sed -e 's/x86_64/64/' -e 's/aarch64/arm64-v8a/') \
    && curl -sLO https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-${arch}.zip \
    && unzip -o -d / v2ray-linux-${arch}.zip

FROM docker.io/library/ubuntu:latest

LABEL org.opencontainers.image.authors="zhiwei@youya.org"
LABEL org.opencontainers.image.documentation="https://github.com/chenzhiwei/dockerfiles"

RUN apt update \
    && apt install -y --no-install-recommends ca-certificates curl \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /v2ray /usr/bin/
COPY --from=builder /config.json /etc/v2ray/config.json

CMD ["v2ray", "run", "-c", "/etc/v2ray/config.json"]
