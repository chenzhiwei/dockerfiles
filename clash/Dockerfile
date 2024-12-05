# podman build --platform linux/arm64,linux/amd64 --manifest docker.io/siji/clash:latest .
# podman manifest push docker.io/siji/clash:latest docker.io/siji/clash:latest
FROM docker.io/library/alpine:latest AS builder

RUN apk add --no-cache curl jq

RUN ARCH=$(uname -m | sed -e 's/x86_64/amd64/' -e 's/aarch64/arm64/') \
    && VERSION=$(curl -s https://api.github.com/repos/MetaCubeX/mihomo/releases/latest | jq -r .name) \
    && curl -LO https://github.com/MetaCubeX/mihomo/releases/download/${VERSION}/mihomo-linux-${ARCH}-${VERSION}.gz \
    && gunzip mihomo-linux-*.gz \
    && chmod +x mihomo-linux-* \
    && mv mihomo-linux-* clash

FROM docker.io/library/debian:stable-slim

LABEL org.opencontainers.image.authors="zhiwei@youya.org"
LABEL org.opencontainers.image.documentation="https://github.com/chenzhiwei/dockerfiles"

RUN apt update \
    && apt -y --no-install-recommends install ca-certificates curl iproute2 \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /clash /usr/bin/clash

CMD ["clash", "-d", "/etc/clash"]
