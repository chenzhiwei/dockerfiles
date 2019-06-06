FROM shadowsocks/shadowsocks-libev as base

FROM alpine

COPY --from=base /usr/bin/ss-* /usr/bin/

RUN apk add --no-cache jq rng-tools \
    $(scanelf --needed --nobanner /usr/bin/ss-* | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' | sort -u) \
    && V2RAY_PLUGIN_VERSION=$(wget -q -O - https://api.github.com/repos/shadowsocks/v2ray-plugin/releases/latest | jq -r .name) \
    && wget -P /tmp https://github.com/shadowsocks/v2ray-plugin/releases/download/${V2RAY_PLUGIN_VERSION}/v2ray-plugin-linux-amd64-${V2RAY_PLUGIN_VERSION}.tar.gz \
    && tar xf /tmp/v2ray-plugin-linux-amd64-${V2RAY_PLUGIN_VERSION}.tar.gz -C /tmp/ \
    && mv /tmp/v2ray-plugin_linux_amd64 /usr/bin/v2ray-plugin \
    && rm -rf /tmp/*
